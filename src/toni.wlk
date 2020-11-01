import wollok.game.*
import plantas.*
import pachamama.*
import mercados.*
import visualYMovimientos.*

object toni {
	const property image = "toni.png"
	var property position = game.at(3, 3)
	var property plantasSembradas = []
	var property plantasCosechadas = []
	var property oroObtenido = 0
	var property gastoDiario = 200

		
	// Pegar acá todo lo que tenían de Toni en la etapa 1
	
	method sembrarMaiz() {
		if (not self.listaDePosicionesSembrdas().contains(self.position()) ) {
			plantasSembradas.add(new Maiz(position=self.position()))
			game.addVisual(plantasSembradas.last())	
		}
		else self.error("Ya hay siembra")	
	}		

	
	method sembrarTrigo() {
		if (not self.listaDePosicionesSembrdas().contains(self.position()) ) {
			plantasSembradas.add(new Trigo(position=self.position()))
			game.addVisual(plantasSembradas.last())
		}
		else self.error("Ya hay siembra")		
	}		


	method sembrarTomaco() {
		if (not self.listaDePosicionesSembrdas().contains(self.position()) ) {
			plantasSembradas.add(new Tomaco(position=self.position()))
			game.addVisual(plantasSembradas.last())
		}
		else self.error("Ya hay siembra")		
	}		


	method regarLasPlantas() {
		plantasSembradas.forEach( { p=>p.regar() } )
	}
	
	method regarPlanta () {
		game.colliders(self).forEach ( { planta => planta.regar() } )
	}
	
	method plantasListasParaCosechar() {
		return plantasSembradas.filter( { p=>p.listaParaCosechar() } )
	}

	method cosecharPlanta() {
//		**** Agrego validacion de que hay planta para cosechar ******
		if (self.estaEnPlantaCosechable()) {
			const planta = game.uniqueCollider(self)
			game.removeVisual(planta) 
			plantasCosechadas.add(planta)
			plantasSembradas.remove(planta)						
		}
		else if (self.estaEnPlantaSembrada()) { self.error("No está lista para cosechar") }
		else { self.error("Acá NO hay planta") }		
	}

//		*** Métodos para validar que está en planta cosechable ************	
	method estaEnPlantaCosechable() { return self.listaDePosicionesCosechables().contains(self.position()) }
	method listaDePosicionesCosechables() { return self.plantasListasParaCosechar().map( { p=>p.position() } ) }
	method estaEnPlantaSembrada() { return self.listaDePosicionesSembrdas().contains(self.position()) }
	method listaDePosicionesSembrdas() { return self.plantasSembradas().map( { p=>p.position() } ) }

//		***********************************************************************

	method cosecharTodo() {
		self.plantasListasParaCosechar().forEach( { p=>p.cosechate() } )
		game.say(self,"Total " + plantasCosechadas.size() + " plantas cosechadas")
	}

	method valorCosecha() {
		return plantasCosechadas.sum( { p=>p.cuantoOroDa() } )
	}
	
	method venderCosecha() {
		oroObtenido += self.valorCosecha()
		plantasCosechadas.clear()
	}
	
	method  paraCuantosDiasLeAlcanza() {
		return (oroObtenido + self.valorCosecha()) / gastoDiario
	}
	
	method cuantoHayParaCeliacos() {
		return self.plantasListasParaCosechar().count( { p=>p.esAptoCeliaco() } )
	}
	
	method convieneRegar() {
		return self.plantasSembradas().any( { p=> not p.listaParaCosechar() } )
	}
	
	method hacerOfrenda(pacha) { 
		pacha.rotarPosicion()
//		******* Agrego validación que haya al menos 1 planta para ofrendar *********
		if (plantasSembradas != []) { plantasSembradas.anyOne().serOfrenda() }		
		if (not pacha.estaAgradecida()) { pacha.nivelAgradecimiento(10) }	
		else {pacha.llover() self.regarLasPlantas()}					
	}
	
	method venderEnMercado() {
		if(position == mercadoCentral.position() ) 
		{ mercadoCentral.aceptarCompra() }
		else if (position == mercadoChino.position()) 
			{ mercadoChino.aceptarCompra() }
		else{ self.error("no hay ningun mercado")}
	}	
	
	
}