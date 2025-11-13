import { useState } from "react";
import { api } from "../services/api";

export default function Register() {
  const [form, setForm] = useState({
    nombre: "",
    apellido_paterno: "",
    correo: "",
    password: "",
    password_confirmation: "",
  });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.post("/register", form);
      alert("Usuario registrado correctamente ✅");
    // eslint-disable-next-line no-unused-vars
    } catch (error) {
      alert("Error al registrar usuario ❌");
    }
  };

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h2>Registro</h2>
      <form onSubmit={handleSubmit}>
        <input name="nombre" placeholder="Nombre" onChange={handleChange} />
        <input name="apellido_paterno" placeholder="Apellido paterno" onChange={handleChange} />
        <input name="correo" type="email" placeholder="Correo" onChange={handleChange} />
        <input name="password" type="password" placeholder="Contraseña" onChange={handleChange} />
        <input name="password_confirmation" type="password" placeholder="Confirmar contraseña" onChange={handleChange} />
        <button>Registrar</button>
      </form>
    </div>
  );
}
