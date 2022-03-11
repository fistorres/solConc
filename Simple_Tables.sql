CREATE	TABLE	musico_artista (
		id	        NUMERIC(6),
		nome        VARCHAR(40)	NOT	NULL,
		n_artistico	VARCHAR(20)	NOT	NULL,
		ano	        NUMERIC(4) NOT	NULL, 
		PRIMARY	KEY	(id),
        UNIQUE	(n_artistico),																		
		CHECK	(id >	0),
        CHECK	(ano	BETWEEN	1900	AND	2100)	
);

CREATE	TABLE	papel_musical (
		papel       CHAR(15),
		descricao	VARCHAR(30) NOT	NULL,
		UNIQUE	(descricao)				
);

CREATE	TABLE	habilitado (
		musico NUMERIC(6),
		papel CHAR(15),
		nivel CHAR,
		PRIMARY	KEY	(musico,papel),	
		CHECK	(nivel	in	('P','A')),
		FOREIGN	KEY	(musico) REFERENCES	musico_artista (id),
		FOREIGN	KEY	(papel) REFERENCES	papel_musical (papel)
);

CREATE	TABLE	banda_artista (
		codigo	NUMERIC(5), 
		nome	VARCHAR(30) NOT	NULL,
		tipo	CHAR(5)	 NOT	NULL,
		ano		NUMERIC(4)	 NOT	NULL,
		PRIMARY	KEY	(codigo),
		UNIQUE (nome),
		CHECK	(tipo	in	('banda','solo')),
		CHECK	(ano BETWEEN	1900	AND	2100),
);
CREATE	TABLE	desempenha (
		banda_artista	NUMERIC(5),	
		musico	 		NUMERIC(6),
		papel 			CHAR(15),
		cachet 			NUMERIC(3) NOT	NULL,
		PRIMARY	KEY	(banda_artista,musico,papel),
		CHECK	(cachet	BETWEEN	0	AND	100),
		FOREIGN	KEY	(banda_artista)	REFERENCES	banda_artista	(codigo),
        FOREIGN	KEY	(musico,papel) 	REFERENCES	habilitado (musico,papel)
);