---SCRIPTS GENERALES---
include("scripts.utility.utility")
include("scripts.characters.characters")
include("scripts.compatibility.compatibility")
include("scripts.entities.entities")
include("scripts.loaders.loaders")
include("scripts.libraries.libraries")

---SCRIPTS DE ITEMS PASIVOS Y ACTIVOS----
include("scripts.items.itemBebida")
include("scripts.items.itemCV")
include("scripts.items.itemCacahuetillo")
include("scripts.items.itemCafe")
include("scripts.items.itemContrato")
include("scripts.items.itemMedicamento")
include("scripts.items.itemPasta")
include("scripts.items.itemSenyorC")
include("scripts.items.itemTreintaytres")
include("scripts.items.itemPapel")

include("scripts.items.itemJuramentada")
include("scripts.items.itemPalabrasRadiantes")

--SCRIPTS TRANSFORMACIONES--
include("scripts.transformation.transformationKnightRadiant")

---SCRIPTS DE TRINKETS----
include("scripts.trinkets.trinketTenedol")
include("scripts.trinkets.trinketVozDeRoro")
include("scripts.trinkets.trinketOh")



---Bug general: al conseguir uno de los trinkets, el jugador obtiene a su vez el ítem "Sad onion"---
--Depende del activo, puede llegar a dar "sad onion" también, jappens---