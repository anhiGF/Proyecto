<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class RolMiddleware
{
    public function handle(Request $request, Closure $next, $rol)
    {
        $userId = $request->user()->id_usuario;

        $hasRol = \DB::table('usuario_rol')
            ->join('rol', 'usuario_rol.id_rol', '=', 'rol.id_rol')
            ->where('usuario_rol.id_usuario', $userId)
            ->where('rol.nombre', $rol)
            ->exists();

        if (!$hasRol) {
            return response()->json(['error' => 'Acceso denegado'], 403);
        }

        return $next($request);
    }
}
