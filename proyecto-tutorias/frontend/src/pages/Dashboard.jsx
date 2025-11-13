import { useContext } from "react";
import { AuthContext } from "../context/AuthContext";

export default function Dashboard() {
  const { user, logout } = useContext(AuthContext);

  if (!user) return null;

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h1>Bienvenido, {user.nombre} 👋</h1>
      <p>Correo: {user.correo}</p>
      <button onClick={logout}>Cerrar sesión</button>
    </div>
  );
}
