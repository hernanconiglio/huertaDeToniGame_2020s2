import wollok.game.*
import plantas.*
import toni.*
import pachamama.*
import mercados.*

object juego {
	var property personajeActual = toni
	
	method configurarTeclado() {
/* 		Acciones de la Pachamama */
		keyboard.f().onPressDo({ pachamama.fumigar() })
		keyboard.l().onPressDo({ pachamama.llover() })		


/*		Acciones de Toni */		
		keyboard.m().onPressDo({ toni.sembrarMaiz() })
		keyboard.t().onPressDo({ toni.sembrarTrigo() })
		keyboard.o().onPressDo({ toni.sembrarTomaco() })
		keyboard.c().onPressDo({ toni.cosecharPlanta() })
		keyboard.x().onPressDo({ toni.cosecharTodo() })
		keyboard.r().onPressDo({ toni.regarPlanta() })
		keyboard.a().onPressDo({ toni.regarLasPlantas() })
		keyboard.v().onPressDo({ toni.venderEnMercado() })
		keyboard.space().onPressDo({
			game.say(toni,"Tengo " + toni.oroObtenido() + " de oro obtenido " + 
			" y me quedan " + toni.plantasCosechadas().size() + " plantas para vender")
		})
		self.configurarMovimiento()
		
	}
	
	method configurarMovimiento(){
		keyboard.up().onPressDo({
			if(personajeActual.position().y() != game.height() - 1) {
				personajeActual.position(personajeActual.position().up(1))
			}
			else { personajeActual.position( new Position(x=personajeActual.position().x(),y=0) ) }
		})
		keyboard.down().onPressDo({
			if(personajeActual.position().y() != 0){
				personajeActual.position(personajeActual.position().down(1))
			}
			else { personajeActual.position( new Position(x=personajeActual.position().x(),y=game.height() - 1) ) }
		})
		keyboard.left().onPressDo({
			if(personajeActual.position().x() != 0){
				personajeActual.position(personajeActual.position().left(1))
			}
			else { personajeActual.position( new Position(x=game.width() - 1,y=personajeActual.position().y())) } 
		})
		keyboard.right().onPressDo({
			if(personajeActual.position().x() != game.width() - 1){
				personajeActual.position(personajeActual.position().right(1))
			}
			else { personajeActual.position( new Position(x=0,y=personajeActual.position().y())) }
		})
		
		
	}
	method configurarPersonajes(){
		game.addVisual(toni)
		game.addVisual(pachamama)
		game.addVisual(mercadoCentral)
		game.addVisual(mercadoChino)
	}	
	
	
}
