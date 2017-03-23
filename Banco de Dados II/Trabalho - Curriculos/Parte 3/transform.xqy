declare function local:transform($nodes as node()*) as node()*
{
	for $n in $nodes return
		typeswitch ($n)
			case text() return $n
			case element (curriculum) return <curriculo>{local:transform($n/node())}</curriculo>
			case element (dados-pessoais) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (lote) return <numero>{local:transform($n/node())}</numero>
			case element (formacao-item) return <titulacao>{local:transform($n/node())}</titulacao>
			case element (curso) return <especialidade>{local:transform($n/node())}</especialidade>
			case element (conclusao) return <anoFormatura>{local:transform($n/node())}</anoFormatura>
			case element (exp-prof) return <experiencia>{local:transform($n/node())}</experiencia>
			(: case element (instituicao) return <empresa>{local:transform($n/node())}</empresa> :)
			case element (atividade) return <resumo>{local:transform($n/node())}</resumo>
			case element (qualificacao) return <proficiencia_linguistica>{local:transform($n/node())}</proficiencia_linguistica>
			case element (info-adicional) return <FormacaoComplementar>{local:transform($n/node())}</FormacaoComplementar>
			case element (dados_pessoais) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (formacao_academica) return <formacao>{local:transform($n/node())}</formacao>
			case element (experiencia_profissional) return <experiencia>{local:transform($n/node())}</experiencia>
			case element (CurriculumVitae) return <curriculo>{local:transform($n/node())}</curriculo>
			case element (header) return <cabecalho>{local:transform($n/node())}</cabecalho>
			case element (name) return <nome>{local:transform($n/node())}</nome>
			case element (info) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (prof_linguistic) return <proficiencia_linguistica>{local:transform($n/node())}</proficiencia_linguistica>
			case element (WorkExperience) return <experiencia>{local:transform($n/node())}</experiencia>
			case element (ComplementaryActivities) return <FormacaoComplementar>{local:transform($n/node())}</FormacaoComplementar>
			case element (Pessoa) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (logradouro) return <rua>{local:transform($n/node())}</rua>
			case element (address) return <endereco>{local:transform($n/node())}</endereco>
			case element (adress) return <endereco>{local:transform($n/node())}</endereco>
			case element (DADOS-GERAIS) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (NOME-COMPLETO) return <nomeCompleto>{local:transform($n/node())}</nomeCompleto>
			case element (DATA-NASCIMENTO) return <dataNascimento>{local:transform($n/node())}</dataNascimento>
			case element (UF) return <estado>{local:transform($n/node())}</estado>
			case element (ENDERECO) return <endereco>{local:transform($n/node())}</endereco>
			case element (BAIRRO) return <bairro>{local:transform($n/node())}</bairro>
			case element (CIDADE) return <cidade>{local:transform($n/node())}</cidade>
			case element (CV) return <curriculo>{local:transform($n/node())}</curriculo>
			case element (Email) return <email>{local:transform($n/node())}</email>
			case element (Endereco) return <endereco>{local:transform($n/node())}</endereco>
			case element (Educacao) return <Formacao>{local:transform($n/node())}</Formacao>
			case element (Extracurricular) return <experiencia>{local:transform($n/node())}</experiencia>
			case element (root) return <cabecalho>{local:transform($n/node())}</cabecalho>
			case element (informacaopessoal) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (quando) return <periodo>{local:transform($n/node())}</periodo>
			case element (FormacaoExtra) return <FormacaoComplementar>{local:transform($n/node())}</FormacaoComplementar>
			case element (Logradouro) return <rua>{local:transform($n/node())}</rua>
			case element (Numero) return <numero>{local:transform($n/node())}</numero>
			case element (Rua) return <rua>{local:transform($n/node())}</rua>
			case element (Bairro) return <bairro>{local:transform($n/node())}</bairro>
			case element (Complemento) return <complemento>{local:transform($n/node())}</complemento>
			case element (Cidade) return <cidade>{local:transform($n/node())}</cidade>
			case element (Estado) return <estado>{local:transform($n/node())}</estado>
			case element (Name) return <nome>{local:transform($n/node())}</nome>
			case element (Nascimento) return <dataNascimento>{local:transform($n/node())}</dataNascimento>
			case element (Empresa) return <empresa>{local:transform($n/node())}</empresa>
			case element (Cargo) return <resumo>{local:transform($n/node())}</resumo>
			case element (Inicio) return <inicio>{local:transform($n/node())}</inicio>
			case element (Fim) return <termino>{local:transform($n/node())}</termino>
			case element (Experiencias) return <experiencia>{local:transform($n/node())}</experiencia>
			case element (Experiencia) return <experiencia>{local:transform($n/node())}</experiencia>
			case element (cv) return <curriculo>{local:transform($n/node())}</curriculo>
			case element (identificacao) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (formacaoAcademica) return <Formacao>{local:transform($n/node())}</Formacao>
			case element (Curriculum_vitae) return <curriculo>{local:transform($n/node())}</curriculo>
			case element (Dados_Pessoais) return <infopessoal>{local:transform($n/node())}</infopessoal>
			case element (Nome) return <nome>{local:transform($n/node())}</nome>
			case element (municipalty) return <cidade>{local:transform($n/node())}</cidade>
			case element (state) return <estado>{local:transform($n/node())}</estado>
			case element (street) return <rua>{local:transform($n/node())}</rua>
			case element (neighborhood) return <bairro>{local:transform($n/node())}</bairro>
			case element (descricaoTrabalho) return <resumo>{local:transform($n/node())}</resumo>
			case element (qualificacao_linguistica) return <proficiencia_linguistica>{local:transform($n/node())}</proficiencia_linguistica>
			case element (exp-prof) return <experiencia>{local:transform($n/node())}</experiencia>
			case element (Body) return <cabecalho>{local:transform($n/node())}</cabecalho>
			case element (linguas) return <proficiencia_linguistica>{local:transform($n/node())}</proficiencia_linguistica>
			case element (QualificacoesAcademicas) return <listaComplementos>{local:transform($n/node())}</listaComplementos>
			case element (complement) return <complemento>{local:transform($n/node())}</complemento>
			case element (begin) return <inicio>{local:transform($n/node())}</inicio>
			case element (end) return <termino>{local:transform($n/node())}</termino>
			case element() return element {name($n)} {local:transform($n/node())}
			default return local:transform($n/node())
			(: case element (foo) return <fooo>{local:transform($n/node())}</fooo> :)
};

let $x := doc("PEDRO IGOR DE ARAUJO OLIVEIRA.xml") return local:transform($x)