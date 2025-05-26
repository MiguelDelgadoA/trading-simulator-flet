import asyncio
import websockets
import json
import threading

page = None  # Declaramos globalmente
texts = None


async def listen_binance(ticker,text_widget):
    global page

    uri = f"wss://stream.binance.com:9443/ws/{ticker}@trade"
    async with websockets.connect(uri) as websocket:
        while True:
            msg = await websocket.recv()
            data = json.loads(msg)
            price = data["p"]
            cripto = data["s"].replace('USDT', '/USDT')
            text_widget.value = f'{cripto}\n ${price}'
            page.update()
            print(f'{cripto}: ${data}')

def start_async_loop(loop):
    global texts

    asyncio.set_event_loop(loop)
    loop.run_until_complete(asyncio.gather(
        *[listen_binance(ticker, texts[ticker]) for ticker in texts]
    ))  # Puedes agregar más criptomonedas aquí

def new_loop_ws(page_, texts_):
    
    global page,texts
    page = page_
    texts = texts_    
  
    # Inicia el bucle de eventos en un hilo separado
    new_loop = asyncio.new_event_loop()
    t = threading.Thread(target=start_async_loop, args=(new_loop,), daemon=True)
    t.start()