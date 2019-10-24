class NaveEspacial {
	var property velocidad = 0
	var property direccion = 0
	var property combustible = 1000 	
	
	method acelerar(cuanto) { velocidad = (velocidad + cuanto).min(100000) }
	method desacelerar(cuanto) { velocidad -= cuanto }
	
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion += 1 }
	method alejarseUnPocoDelSol() { direccion -= 1 }
	
	method cargarCombustible(cuanto) { combustible += cuanto }
	method descargarCombustible(cuanto) { combustible -= cuanto }
	
	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}
	
	method escapar() {
		self.descargarCombustible(1)		
	}
	
	method avisar()
}

class NaveDeCombate inherits NaveEspacial {
	var property estaInvisible = false
	var property misilesDesplegados = false
	const property mensajesEmitidos = []
	
	method ponerseVisible() { estaInvisible = false }
	method ponerseInvisible() { estaInvisible = true }
	method desplegarMisiles() { misilesDesplegados = true }
	method replegarMisiles() { misilesDesplegados = false }
	method emitirMensaje(mensaje) { mensajesEmitidos.add(mensaje) }
	method emitioMensaje(mensaje) { return mensajesEmitidos.contains(mensaje) }
	
	override method prepararViaje() {
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	
	override method escapar() {
		super()
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		// el "for" de Wollok		
//		new Range(1,40).forEach { n => self.acercarseUnPocoAlSol() }
	}
	
	override method avisar() {
		self.emitirMensaje("Amenaza recibida")
	}

}

class NaveDeCombateSigilosa inherits NaveDeCombate {
	override method escapar() {
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}

class NaveBaliza inherits NaveEspacial {
	var colorDeBaliza = "verde"
	method cambiarColorDeBaliza(colorNuevo) { colorDeBaliza = colorNuevo }
	method colorDeBaliza() = colorDeBaliza
	
	override method prepararViaje() {
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	
	override method escapar() {
		self.irHaciaElSol()
	}
	
	override method avisar() {
		self.cambiarColorDeBaliza("rojo")
	}
}



class NaveDePasajeros inherits NaveEspacial {
	var property cantidadPasajeros = 100
	var property racionesComida = 0
	var property racionesBebida = 0
	
	method cargarComida(cuantasRaciones) { racionesComida += cuantasRaciones }
	method descargarComida(cuantasRaciones) { racionesComida -= cuantasRaciones }
	method cargarBebida(cuantasRaciones) { racionesBebida += cuantasRaciones }
	method descargarBebida(cuantasRaciones) { racionesBebida -= cuantasRaciones }

	override method prepararViaje() {
		super()
		self.cargarBebida(6 * cantidadPasajeros)
		self.cargarComida(4 * cantidadPasajeros)
		self.acercarseUnPocoAlSol()
	}

	override method escapar() {
		self.acelerar(velocidad)
	}
	
	override method avisar() {
		self.descargarBebida(2 * cantidadPasajeros)
		self.descargarComida(cantidadPasajeros)
	}

//	override method recibirAmenaza() {
//		super()
//		self.desacelerar(200)
//	}
} 

class NaveHospital inherits NaveDePasajeros {
	var property quirofanosPreparados
	
	override method recibirAmenaza() {
		super()
		quirofanosPreparados = true
	}
	
	override method escapar() {
		super()
		self.desacelerar(500)
	}
}

