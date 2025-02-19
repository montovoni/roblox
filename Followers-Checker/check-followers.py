import requests
import tkinter as tk
from tkinter import ttk, messagebox

def get_roblox_followers(user_id):
    url = f"https://friends.roblox.com/v1/users/{user_id}/followers?limit=100"
    all_followers = []

    try:
        while url:
            response = requests.get(url)
            response.raise_for_status()

            data = response.json()
            followers = data.get("data", [])
            all_followers.extend(followers)

            url = data.get("nextPageCursor")
            if url:
                url = f"https://friends.roblox.com/v1/users/{user_id}/followers?limit=100&cursor={url}"

        if not all_followers:
            messagebox.showinfo("Aviso", "Nenhum seguidor encontrado.")
            return [], []

        follower_ids = [str(follower["id"]) for follower in all_followers]
        return all_followers, follower_ids

    except requests.exceptions.RequestException as e:
        messagebox.showerror("Erro", f"Erro ao acessar a API: {e}")
        return [], []


def on_search():
    user_id = entry_id.get().strip()
    if not user_id.isdigit():
        messagebox.showerror("Erro", "Por favor, insira um ID válido (somente números).")
        return

    followers, follower_ids = get_roblox_followers(user_id)

    if not followers:
        return

    # Verificando se o seguidor está presente
    follower_to_check = entry_check.get().strip()
    if follower_to_check.isdigit():
        if follower_to_check in follower_ids:
            messagebox.showinfo("Resultado", f"O usuário {follower_to_check} está seguindo você!")
        else:
            messagebox.showinfo("Resultado", f"O usuário {follower_to_check} não está seguindo você.")

# Criando a interface gráfica
root = tk.Tk()
root.title("Verificar Seguidores")
root.geometry("400x200")
root.resizable(False, False)

# Centralizar a tela
root.eval('tk::PlaceWindow . center')

frame = ttk.Frame(root, padding=15)
frame.pack(expand=True)

ttk.Label(frame, text="Digite o ID do seu perfil:", font=("Arial", 10)).pack(pady=5)
entry_id = ttk.Entry(frame, width=25, font=("Arial", 10))
entry_id.pack(pady=5)

ttk.Label(frame, text="Digite o ID do usuário para verificar se ele está te seguindo:", font=("Arial", 10)).pack(pady=5)
entry_check = ttk.Entry(frame, width=25, font=("Arial", 10))
entry_check.pack(pady=5)

btn_search = ttk.Button(frame, text="Verificar", command=on_search)
btn_search.pack(pady=10)

root.mainloop()