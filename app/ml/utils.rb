class Utils
	def self.get_description method
		if(method.eql? MlMethods.get_models.first)
			return "remover esse modelo"
			
		elsif (method.eql? MlMethods.get_models.second)
			return "O modelo LFS é um modelo de Envelopamento que utiliza a
			sequential forward generation para realizar a busca. Para reduzir o número de conjuntos
			avaliados pelo algoritmo, primeiramente todos os conjuntos são ranqueados usando al-
			guma medida de Filtro, em seguida é feito uma seleção de conjuntos ranqueados
			e então é feito a avaliação desses subconjuntos utilizando algum classificador."

		elsif (method.eql? MlMethods.get_models.third)
			return "O algoritimo Relief-F utiliza métodos estatísticos para selecionar as características
			relevantes, é um método que se baseia nos pesos atribuídos às caracterísicas.
			O algorítmo realiza a busca de maneira sequêncial e utiliza medidas de distância para
			poder realizar a avaliação entre as características. Depois de percorrer todas
			as características ele retorna aquelas que têm o valor do peso maior do que o limite estabelecido."

		elsif (method.eql? MlMethods.get_models.fourth)
			return "O modelo DTM utiliza o algoritmo C4.5 para realizar a seleção de características,
			ou seja, utiliza-se um classificador para poder escolher as características, porém ele não é
			um algorítmo de seleção de Envelopamento (wrapper), ele continua sendo um algorítmo
			do tipo Filtro (filter) pelo fato de utilizar medidas internas do classificador relacionadas
			a erro, e não só as medidas de acurácia. (DASH, 1997). Após montar a árvore de decisão,
			é feita a ’poda’ da árvore, e é dessa árvore ’podada’ que são extraídas as características
			que serão utilizadas no classificador final."
		end
	end
end