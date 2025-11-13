<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Models\User;
use App\Models\UsuarioRol;
use App\Models\Rol;

class AuthController extends Controller
{
    // Registro
    public function register(Request $request)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:120',
            'apellido_paterno' => 'required|string|max:120',
            'correo' => 'required|email|unique:usuario,correo',
            'password' => 'required|min:6|confirmed',
        ]);

        $user = \DB::table('usuario')->insertGetId([
            'nombre' => $validated['nombre'],
            'apellido_paterno' => $validated['apellido_paterno'],
            'correo' => $validated['correo'],
            'password_hash' => Hash::make($validated['password']),
            'creado_en' => now(),
            'actualizado_en' => now(),
        ]);

        // Asignar rol por defecto (Tutor)
        $rolTutor = \DB::table('rol')->where('nombre', 'Tutor')->value('id_rol');
        \DB::table('usuario_rol')->insert([
            'id_usuario' => $user,
            'id_rol' => $rolTutor
        ]);

        return response()->json(['message' => 'Usuario registrado correctamente ✅'], 201);
    }

    // Login
    public function login(Request $request)
    {
        $user = \DB::table('usuario')->where('correo', $request->correo)->first();

        if (!$user || !Hash::check($request->password, $user->password_hash)) {
            throw ValidationException::withMessages([
                'correo' => ['Las credenciales no son válidas.'],
            ]);
        }

        $token = \Laravel\Sanctum\PersonalAccessToken::createToken(
            app(\App\Models\User::class)->forceFill(['id' => $user->id_usuario]),
            'auth_token'
        )->plainTextToken;

        return response()->json([
            'token' => $token,
            'usuario' => $user,
        ]);
    }

    // Usuario autenticado
    public function user(Request $request)
    {
        $user = \DB::table('usuario')->where('id_usuario', $request->user()->id)->first();
        $roles = \DB::table('usuario_rol')
            ->join('rol', 'usuario_rol.id_rol', '=', 'rol.id_rol')
            ->where('usuario_rol.id_usuario', $user->id_usuario)
            ->pluck('rol.nombre');

        return response()->json(['usuario' => $user, 'roles' => $roles]);
    }

    // Logout
    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return response()->json(['message' => 'Sesión cerrada correctamente 👋']);
    }
}
