import { useState, useContext } from "react";
import { AuthContext } from "../context/AuthContext";

export default function Login() {
  const { login } = useContext(AuthContext);
  const [correo, setCorreo] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await login(correo, password);
      alert("Inicio de sesión exitoso ✅");
    // eslint-disable-next-line no-unused-vars
    } catch (error) {
      alert("Credenciales incorrectas ❌");
    }
  };

  return (
    <div className="login-container" style={{ textAlign: "center", marginTop: "50px" }}>
      <h2>Iniciar sesión</h2>
      <form onSubmit={handleSubmit}>
        <input
          placeholder="Correo"
          value={correo}
          onChange={(e) => setCorreo(e.target.value)}
        />
        <input
          type="password"
          placeholder="Contraseña"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button>Entrar</button>
      </form>
    </div>
  );
}
