--Key root_max
SENHA_ROOT_MAX             = "948a388842d594797bfd749245cb5ec3a63501b1ee0de97f257fb217382c571b"
SENHA_ROOT_READ            = "594844d023da212ef8f15221d782666c4df907304deca543159a3235c4fe58e7"

--Time_formated
DATE_FORMATED              = "%Y-%m-%d %H:%M:%S"
ONE_DAY_IN_SECONDS         = 86400
TWO_DAYS_IN_SECONDS        = 172800

-- Rotas
API                        = "/api"
ADD                        = "/adicione"
LIST                       = "/lista"
INCREASES                  = "/incrementa"
DECREASES                  = "/decrementa"
BALANCE                    = "/saldo"
LOTE                       = "/lote"
EMAIL_route                = "/email"
DELETE                     = "/deleta"
USER                       = "/usuario"
TOKEN_ROUTE                = "/token"
CURRENT                    = "/corrente"
IMAGEM                     = "/foto"
PREVIEW                    = "/ver"
ALL                        = "/todas"
GUYS                       = "/pessoal"
PERFIL                     = "/perfil"
COMPAR                     = "/compare"
ROSTO                      = "/metricas"

--Responses
ROTA_NAO_ENCONTRADA        = "Rota não encontrada."
ALTENTICA_FALHOU           = "A altenticação falhou."
USUARIO_CRIADO             = "O usuario foi criado."
USER_NOT_FOUND             = "Usuario não encontrado."
USER_SUCCESSFULY_DELETED   = "Usuario excluido com suscesso."
VALUE_INVALID              = "O valor informado é invalido."
VALUE_NOT_FOUND            = "O valor não foi informado."
IMG_ADD                    = "Imagem adicionada ao banco."
IMG_FULL                   = "O limite de imagens a ser guardada foi exsedida."
IMG_DELL                   = "O banco de imagem foi deletada."
IMG_NOT_FOUND              = "Esse usuario não tem fotos."
NOT_FOUND_TOKEN            = "token invalido"
EXPIRED_TOKEN              = "token expirado"
USER_NOT_ROOT              = "O usuario não é root"
ID_INVALID                 = "O id é invalido."
ID_NOT_IMG                 = "Essa imagem não existe no banco."
IMG_JA_ADD                 = "Essa imagem já existe no banco de dados."
FACE_NOT_FOUND             = "Face não encontrada em imagem."

--Headers
ROOT_MAX                   = "root_max"
TOKEN                      = "token"
ROOT_READ                  = "root_read"
ROOT                       = "root"
EMAIL                      = "email"
NOME                       = "nome"
SENHA                      = "senha"
SALDO                      = "saldo"
SALDO_MIN                  = "saldo_min"
SALDO_MAX                  = "saldo_max"
IMG_MAX                    = "img_max"
IMG_MIN                    = "img_min"
VALOR                      = "valor"
ID                         = "id"
FREQ_MIN                   = "frequencia_min"
FREQ_MAX                   = "frequencia_max"
CONTENT_TYPE               = "content-type"

--Banco
BANCO                      = "data"
USERS_BANCO                = "usuarios"
VALUE_BANCO                = "value"
EMAIL_BANCO                = "email"
NOME_BANCO                 = "nome"
SALDO_BANCO                = "saldo"
ROOT_BANCO                 = "root"
SENHA_BANCO                = "senha"
CLASS_BANCO                = "class"
FREQUENCY_BANCO            = "frequencia"
SHA_IMAGE                  = "sha"
--Banco Transações
TRANSACOES_BANCO           = "transacoes"
VALOR_BANCO_TRANSACOES     = "valor"
DATA_BANCO_TRANSACOES      = "data"
SALDO_NOW_BANCO_TRANSACOES = "saldo_now"
--Banco imagens
IMGS_BANCO                 = "imagens"
IMG                        = "imagem.jpg"
DATE                       = "data"
FACE_DETECTED              = "face"
FACE_METRICS               = "metrics"
--Banco perfil
DIR_PERFIL                 = "perfil"
IMG_PERFIL                 = "foto_perfil.jpg"
BOOL_PERFIL                = "bool"
--Token
CRIACAO                    = "criacao"
TOKENS                     = "tokens"
TAMANHO_TOTAL              = 50
MAXIMO_DE_TOKENS           = 5
EXPIRACAO                  = 30
VALOR_DEBITADO_POR_FACE    = 80

--extra
NULL                       = "null"
EXTRACT_IMG                = "./dependencies/dlib_face_detection/extract_face_metrics"
COMPAR_IMG                 = "./dependencies/dlib_face_detection/compare_face_metrics"

--set_server
set_server.single_process  = false
set_server.nullterminator  = NULL

--content/type
TYPE_JPEG                  = "image/jpeg"
