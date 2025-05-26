import flet as ft

from ws.binance_ws import new_loop_ws
from config.settings import tickers



def main(page: ft.Page):
    texts = {}# Diccionario: clave = ticker, valor = widget de texto
    for ticker in tickers:
        text = ft.Text(value=f"{ticker.upper()}\n Conectando...", size=14, color="green")
        container = ft.Container(
            content=text,
            padding=5,
            border=ft.border.all(1, ft.Colors.BLACK),
            border_radius=5,
            bgcolor=ft.Colors.WHITE,
            width=130,
            height=50           
        )
        texts[ticker]=text
        page.add(container)

    page.title = "Trading Simulator"
    page.scroll = ft.ScrollMode.ALWAYS
  


    new_loop_ws(page, texts)  # Inicia el bucle de eventos en un hilo separado

ft.app(target=main)

