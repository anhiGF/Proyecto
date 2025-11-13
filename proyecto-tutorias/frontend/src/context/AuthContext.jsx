import { createContext, useState, useEffect } from "react";
import { api } from "../services/api";

const AuthContext = createContext();
export { AuthContext };

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  const login = async (correo, password) => {
    const res = await api.post("/login", { correo, password });
    localStorage.setItem("token", res.data.token);
    api.defaults.headers.common["Authorization"] = `Bearer ${res.data.token}`;
    setUser(res.data.usuario);
  };

  const logout = async () => {
    try {
      await api.post("/logout");
    } catch { /* empty */ }
    localStorage.removeItem("token");
    setUser(null);
  };

  const checkUser = async () => {
    const token = localStorage.getItem("token");
    if (token) {
      api.defaults.headers.common["Authorization"] = `Bearer ${token}`;
      try {
        const res = await api.get("/user");
        setUser(res.data.usuario);
      } catch {
        logout();
      }
    }
  };

  useEffect(() => {
    checkUser();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}