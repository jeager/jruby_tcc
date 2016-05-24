class Utils
	def self.get_description method
		if(method.eql? "Filter Method")
			return "O método de filtro é responsável por comparar os subconjuntos 1 a 1. É bem mais 
			rápido do que o método de envelopamento."
		elsif (method.eql? "Wrapper Method")
			return "O método de Wrapper, também conhecido como por envelopamento, é um método que utiliza um classificador
			para poder avaliaros subconjuntos, o tempo de processamento costuma ser bem alto."
		elsif (method.eql? "Relief-F")
			return "O método Relief-F é totalmente matemático, ele compara os métodos e encontra os melhores
			subconjuntos após ranquea-los."
		end
	end
end