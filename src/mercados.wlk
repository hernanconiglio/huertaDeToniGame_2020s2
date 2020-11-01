import wollok.game.*
import toni.*


class Mercado {
	var property image = "mercado.png"
	var property position
	var property oro
	var property mercaderia = []
		
	method aceptarCompra(){ 
		if(oro >= toni.valorCosecha()) {
		oro -= toni.valorCosecha()
		mercaderia.addAll(toni.plantasCosechadas())
		toni.venderCosecha()
	}
	else { self.error("no puedo cubrir esa venta") }
	}
}	
	
	const mercadoCentral = new Mercado(oro=1000,position=game.at(13,7)) 
	const mercadoChino = new Mercado(oro=10,position=game.at(7,13),image="mercado_chino_opt.png")		
