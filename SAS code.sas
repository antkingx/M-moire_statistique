
Code SAS

/*Définition d’une librairie*/
LIBNAME cycle1 "/home/u59972615/mémoire" ;

/*Création de la base de données ess6 dans la library work */
DATA ess6 ;
SET cycle1.ess6 ;
RUN;

/*I-Religion et facteurs sociologiques*/
/*I-1-Religion en France*/
/*Création de la base de données spécifique à la France*/
DATA france ;
SET ess6 ;
WHERE cntry="FR" ;
RUN;

/*Définition de la variable pondération*/
DATA france ;
SET france ;
pond = pspwght*pweight*10000 ;
RUN;

/*Recodage de la variable religion*/
DATA france ;
SET france ;
LENGTH religion $ 30 ;
IF rlgdnm = "1" THEN religion = "Catholique" ;
ELSE IF rlgdnm = "2" THEN religion = "Protestant" ;
ELSE IF rlgdnm = "3" THEN religion = "Orthodoxe" ;
ELSE IF rlgdnm = "4" THEN religion = "Autre religion chrétienne" ;
ELSE IF rlgdnm = "5" THEN religion = "Juive" ;
ELSE IF rlgdnm = "6" THEN religion = "Islam" ;
ELSE IF rlgdnm = "7" THEN religion = "Religion orientale" ;
ELSE IF rlgdnm = "8" THEN religion = "Autre religion non chrétienne" ;
ELSE IF rlgdnm = "66" THEN religion = "Sans religion" ;
ELSE IF rlgdnm = "77" THEN religion = "Refus de réponse" ;
ELSE IF rlgdnm = "99" THEN religion = "Sans réponse" ;
ELSE religion = "" ;
RUN;

/*Diagramme de la répartition des croyances religieuses*/
PROC GCHART DATA = france ;
HBAR religion / DISCRETE DESCENDING PERCENT FREQ=pond ;
RUN;QUIT ;

/*Création d’une table avec 4 religions*/
DATA reduit ;
SET france ;
RUN;
DATA reduit ;
SET reduit ;
LENGTH religion $ 30 ;
IF rlgdnm = "1" THEN religion = "Catholique" ;
ELSE IF rlgdnm = "2" THEN religion = "Protestant" ;
ELSE IF rlgdnm = "3" THEN religion = "" ;
ELSE IF rlgdnm = "4" THEN religion = "" ;
ELSE IF rlgdnm = "5" THEN religion = "Juive" ;
ELSE IF rlgdnm = "6" THEN religion = "Islam" ;
ELSE IF rlgdnm = "7" THEN religion = "" ;
ELSE IF rlgdnm = "8" THEN religion = "" ;
ELSE IF rlgdnm = "66" THEN religion = "Sans religion" ;
ELSE IF rlgdnm = "77" THEN religion = "" ;
ELSE IF rlgdnm = "99" THEN religion = "" ;
ELSE religion = "" ;
RUN;

/*Définition de la variable de pondération dans la nouvelle base de données*/
DATA reduit ;
SET reduit ;
pond = pspwght*pweight*10000 ;
RUN;

/*Codage de la variable tranche d’âge*/
DATA reduit ;
SET reduit ;
LENGTH trancheage$30;
IF17 < agea < 25THENtrancheage = ”18 − 24”;
ELSEIF24 < agea < 35THENtrancheage = ”25 − 34”;
ELSEIF34 < agea < 45THENtrancheage = ”35 − 44”;
ELSEIF44 < agea < 55THENtrancheage = ”45 − 54”;
ELSEIF54 < agea < 65THENtrancheage = ”55 − 64”;
ELSEIF64 < agea < 80THENtrancheage = ”65 − 79”;
RUN;

/*Graphique de la répartition des croyances religieuses par tranche d’âge*/
PROC SORT DATA=reduit ;
BY trancheage;
RUN;
PROC FREQ DATA=reduit NOPRINT;
BY trancheage;
TABLESreligion/out = FreqOut;
WEIGHTpond;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR trancheage/GROUP = religionSEGLABELresponse = Percent;
RUN;


/*Création de la base de données spécifique à l’Italie*/
DATA italie ;
SET ess6 ;
WHERE cntry="IT" ;
RUN;


/*Définition de la variable pondération*/
DATA italie ;
SET italie ;
pond = pspwght*pweight*10000 ;
RUN;


/*Recodage de la variable religion*/
DATA italie ;
SET italie ;
LENGTH religion $ 30 ;
IF rlgdnm = "1" THEN religion = "Catholique" ;
ELSE IF rlgdnm = "2" THEN religion = "Protestant" ;
ELSE IF rlgdnm = "3" THEN religion = "Orthodoxe" ;
ELSE IF rlgdnm = "4" THEN religion = "Autre religion chrétienne" ;
ELSE IF rlgdnm = "5" THEN religion = "Juive" ;
ELSE IF rlgdnm = "6" THEN religion = "Islam" ;
ELSE IF rlgdnm = "7" THEN religion = "Religion orientale" ;
ELSE IF rlgdnm = "8" THEN religion = "Autre religion non chrétienne" ;
ELSE IF rlgdnm = "66" THEN religion = "Sans religion" ;
ELSE IF rlgdnm = "77" THEN religion = "Refus de réponse" ;
ELSE IF rlgdnm = "99" THEN religion = "Sans réponse" ;
ELSE religion = "" ;
RUN;


/*Diagramme de la répartition des croyances religieuses en Italie*/
PROC GCHART DATA = italie ;
HBAR religion / DISCRETE DESCENDING PERCENT FREQ=pond ;
RUN;QUIT ;


/*Codage d’une variable de fréquence de pratique religieuse*/
DATA reduit ;
SET reduit ;
LENGTH rlgfreq $ 30 ;
IF rlgatnd = "1" THEN rlgfreq = "Tous les jours" ;
ELSE IF rlgatnd = "2" THEN rlgfreq = "Tous les mois" ;
ELSE IF rlgatnd = "3" THEN rlgfreq = "Tous les mois" ;
ELSE IF rlgatnd = "4" THEN rlgfreq= "Tous les mois" ;
ELSE IF rlgatnd = "5" THEN rlgfreq = "Qu’au moment des fêtes" ;
ELSE IF rlgatnd = "6" THEN rlgfreq = "" ;
ELSE IF rlgatnd = "7" THEN rlgfreq = "Jamais" ;
ELSE IF rlgatnd = "77" THEN rlgfreq = "" ;
ELSE IF rlgatnd = "88" THEN rlgfreq= "" ;
18
ELSE IF rlgatnd = "99" THEN rlgfreq = "" ;
ELSE rlgatnd = "" ;


/*Graphique des pratiques religieuses par religion*/
PROC SORT DATA=reduit ;
BY religion ;
RUN;
PROC FREQ DATA=reduit NOPRINT;
BY religion ;
TABLES rlgfreq / out=FreqOut ;
WEIGHT pond ;
RUN;
PROC SGPLOT Data=FreqOut ;
VBAR religion / GROUP = rlgfreq SEGLABEL response = Percent ;
WHERE religion NE "Sans religion" ;
RUN;


/*I-2- Religion et discrimination*/
/*Définition d’une variable de ressenti discrimination*/
DATA reduit ;
SET reduit ;
LENGTH dscr $ 30 ;
IF dscrgrp = "1" THEN dscr = "Oui" ;
ELSE IF dscrgrp = "2" THEN dscr = "Non" ;
ELSE IF dscrgrp = "8" THEN dscr = "Ne sait pas" ;
ELSE IF dscrgrp = "7" THEN dscr = "" ;
ELSE IF dscrgrp = "9" THEN dscr = "" ;
ELSE dscr = "" ;
LABEL dscr="Membre d’un groupe discriminé dans le pays" ;
format all;
RUN;


/*Graphique de ressenti de discrimination par religion*/
PROC SORT DATA=reduit ;
BY religion ;
RUN;


PROC FREQ DATA=reduit NOPRINT;
BY religion ;
TABLES dscr / out=FreqOut ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR religion / GROUP = dscr SEGLABEL response = Percent ;
RUN;


/*Définition d’une variable de ressenti discrimination pour la religion*/
DATA reduit ;
SET reduit ;
LENGTH dscrr $ 30 ;

IF dscrrlg = "0" THEN dscrr = "Non marquée" ;
ELSE IF dscrrlg = "1" THEN dscrr = "Marquée" ;
ELSE dscrr = "" ;
LABEL dscrr="Discrimination du groupe du répondant : religion" ;
format all;
RUN;


/*Graphique de ressenti discrimination pour la religion, par religion*/
PROC SORT DATA=reduit ;
BY religion ;
RUN;


PROC FREQ DATA=reduit NOPRINT;
BY religion ;
TABLES dscrr / out=FreqOut ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR religion / GROUP = dscrr SEGLABEL response = Percent ;
RUN;


/*I-3- Religion et bien-être*/
/*Définition d’une variable sentiment de bonheur*/
DATA reduit ;
SET reduit ;
LENGTH bonheur $ 30 ;
IF happy = "0" THEN bonheur = "Pas heureux" ;
ELSE IF happy = "1" THEN bonheur = "Pas heureux" ;
ELSE IF happy = "2" THEN bonheur = "Pas heureux" ;
ELSE IF happy = "3" THEN bonheur = "Pas heureux" ;
ELSE IF happy = "4" THEN bonheur = "Heureux" ;
ELSE IF happy = "5" THEN bonheur = "Heureux" ;
ELSE IF happy = "6" THEN bonheur = "Heureux" ;
ELSE IF happy = "7" THEN bonheur = "Très heureux" ;
ELSE IF happy = "8" THEN bonheur = "Très heureux" ;
ELSE IF happy = "9" THEN bonheur = "Très heureux" ;
ELSE IF happy = "10" THEN bonheur = "Très heureux" ;
ELSE bonheur = "" ;
LABEL bonheur = "Vous sentez-vous heureux ?" ;
FORMAT all;
RUN;


/*Graphique du sentiment de bonheur par religion*/
PROC SORT DATA=reduit ;
BY religion ;
RUN;


PROC FREQ DATA=reduit NOPRINT;
BY religion ;
TABLES bonheur / out=FreqOut ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR religion / GROUP = bonheur SEGLABEL response = Percent ;
RUN;
/*II- Religion et facteurs économiques*/
/*II-1- Taux de chômage*/
LIBNAME ESSog "W :Aémoire" ;
DATA ess ; set ESSog.ess6e024;
IFcntry = ”FR”;
IFrlgdnmNE”77”ANDrlgdnmNE”99”;
RUN;


/* pondération */
DATA ess ;
SET ess ;
pond = pspwght*pweight*10000 ;
RUN;


/* variables sur l’activité pro*/
DATA ess ;
SET ess ;
LENGTH activite $ 100 ;
IF icomdng = 2 THEN DO;
IF PDWRK = 1 THEN activite = "01" ;
IF EDCTN = 1 THEN activite = "02" ;
IF UEMPLA = 1 THEN activite = "03" ;
IF UEMPLI = 1 THEN activite = "04" ;
IF DSBLD = 1 THEN activite = "05" ;
IF RTRD = 1 THEN activite = "06" ;
IF CMSRV = 1 THEN activite = "07" ;
IF HSWRK = 1 THEN activite = "08" ;
IF DNGOTH = 1 THEN activite = "09" ;
IF DNGREF = 1 THEN activite = "77" ;
IF DNGDK = 1 THEN activite = "88" ;
IF DNGNA = 1 THEN activite = "99" ;
END;
RUN;
DATA ess ;
SET ess ;
IF icomdng = 1 THEN DO;
IF mainact NE 88 THEN activite = "0"||PUT(mainact,1.) ;
ELSE activite = "88" ;
END;
RUN;
DATA ess ;
SET ess ;
LENGTH statut $ 20 ;
IF icomdng = 2 THEN DO;
21
IF activite = "01" THEN statut = "travail" ;
IF activite = "07" THEN statut = "travail" ;
IF activite = "02" THEN statut = "chômage" ;
IF activite = "03" THEN statut = "chômage" ;
END;
RUN;


/* Variables religion*/
DATA ess ;
SET ess ;
LENGTH Religion $100 ;
IF rlgdnm="1" THEN Religion = "Chrétien catholique" ;
ELSE IF rlgdnm="2" or rlgdnm="3" or rlgdnm="4" THEN Religion = "Chrétien Protestant/Orthodoxe/autre" ;
ELSE IF rlgdnm="5" THEN Religion = "Juif" ;
ELSE IF rlgdnm="6" THEN Religion = "Musulman" ;
ELSE IF rlgdnm="7" or rlgdnm="8" THEN Religion = "Autres religions" ;
ELSE IF rlgdnm="66" THEN Religion = "Sans Religion" ;
RUN;
DATA ess ;
SET ess ;
LENGTH croyant $ 3 ;
IF rlgdnm NE "66" THEN croyant = "oui" ;
ELSE IF rlgdnm="66" THEN croyant = "non" ;
RUN;


/* travail d’analyse travail vs chomage*/
DATA ess1 ;
SET ess ;
IF statut = "travail" or statut = "chômage" ;
RUN;


/* on commence par croyant non croyant */
PROC SORT DATA=ess1 ;
BY croyant ;
RUN;
PROC FREQ DATA=ess1 NOPRINT;
BY croyant ;
TABLES statut / OUT = FO1 ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FO1 ;
VBAR croyant / GROUP = statut SEGLABEL response = percent ;
/*STYLEATTRS DATACOLORS=(DEYBR )*/ ;
RUN;


/* Toutes les religions */
DATA ess2 ;
SET ess ;
22
IF statut = "travail" or statut = "chômage" ;
RUN;
PROC SORT DATA=ess2 ;
BY Religion ;
RUN;
PROC FREQ DATA=ess2 NOPRINT;
BY Religion ;
TABLES statut / OUT = FO2 ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FO2 ;
VBAR Religion / GROUP = statut SEGLABEL response = percent ;
/*STYLEATTRS DATACOLORS=(DEYBR )*/ ;
RUN;


/*II-2- Répartition des richesses*/
/* analyse de la richesse en fonction des religions*/
DATA ess3 ;
SET ess ;
IF hinctnta NE "77" AND hinctnta NE "88" AND hinctnta NE "99" ;
RUN;
PROC SORT DATA=ess3 ;
BY Religion ;
RUN;
PROC FREQ DATA=ess3 NOPRINT;
BY Religion ;
TABLES hinctnta / OUT = FO3 ;
WEIGHT pond ;
FORMAT hinctnta $formatdecile;
RUN;
PROC SGPLOT Data=FO3 ;
VBAR Religion / GROUP = hinctnta SEGLABEL response = percent ;
RUN;


/* analyse des sources de revenu en fonction de la religion */
DATA ess4 ;
SET ess ;
IF hincsrca NE "77" AND hincsrca NE "88" AND hincsrca NE "99" ;
RUN;


DATA ess4 ;
SET ess4 ;
LENGTH sourcerevenu$50;
IFicomdng = 2THENDO;
IFhincsrca = ”1”THENsourcerevenu = ”1.salaire”;
IFhincsrca = ”2”THENsourcerevenu = ”2.travailindpendant”;
IFhincsrca = ”3”THENsourcerevenu = ”3.travailindpendant(ferme)”;
IFhincsrca = ”4”THENsourcerevenu = ”4.retraite”;
IFhincsrca = ”5”THENsourcerevenu = ”5.aidessociales”;
IFhincsrca = ”6”THENsourcerevenu = ”5.aidessociales”;
IFhincsrca = ”7”THENsourcerevenu = ”6.investissement”;
IFhincsrca = ”8”THENsourcerevenu = ”7.autres”;
END;
RUN;


PROC SORT DATA=ess4 ;
BY Religion ;
RUN;
PROC FREQ DATA=ess4 NOPRINT;
BY Religion ;
TABLES sourcerevenu/OUT = FO4;
WEIGHTpond;
RUN;


PROC SGPLOT Data=FO4 ;
VBAR Religion / GROUP = sourcerevenuSEGLABELresponse = percent;
RUN;


/*II-3- Sources de revenu*/
/* analyse des sources de revenu en fonction de la religion ( hors salaire/ pension et tout )*/
DATA ess5 ;
SET ess ;
IF hincsrca NE "77" AND hincsrca NE "4" AND hincsrca NE "88" AND hincsrca NE "99" ;
RUN;
DATA ess5 ;
SET ess5 ;
LENGTH sourcerevenu$50;
IFicomdng = 2THENDO;
IFhincsrca = ”1”THENsourcerevenu = ”1.salaire”;
IFhincsrca = ”2”THENsourcerevenu = ”2.travailindpendant”;
IFhincsrca = ”3”THENsourcerevenu = ”3.travailindpendant(ferme)”;
IFhincsrca = ”4”THENsourcerevenu = ”4.retraite”;
IFhincsrca = ”5”THENsourcerevenu = ”5.aidessociales”;
IFhincsrca = ”6”THENsourcerevenu = ”5.aidessociales”;
IFhincsrca = ”7”THENsourcerevenu = ”6.investissement”;
IFhincsrca = ”8”THENsourcerevenu = ”7.autres”;
END;
RUN;


PROC SORT DATA=ess5 ;
BY Religion ;
RUN;


PROC FREQ DATA=ess5 NOPRINT;
BY Religion ;
TABLES sourcerevenu/OUT = FO5;
WEIGHTpond;
RUN;
DATA SB ;
SET FO5 ;
IF sourcerevenuNE”5.aidessociales”;
RUN;


PROC SGPLOT Data=SB ;
VBAR Religion / GROUP = sourcerevenuSEGLABELresponse = percent;
RUN;


DATA SBSS ;
SET FO5 ;
IF sourcerevenuNE”5.aidessociales”ANDsourcerevenuNE”1.salaire”;
RUN;


PROC SGPLOT Data=SBSS ;
VBAR Religion / GROUP = sourcerevenuSEGLABELresponse = percent;
RUN;


/*III- Religion et parti politique*/
/*création d’une librairie ESS*/
LIBNAME ess6 "W :6" ;
/*Copie de la table ess6 dans la librairie temporaire work*/
DATA ess ;
SET ess6.ess6e024;
RUN;


DATA ess ;
SET ess ;
IF cntry = "FR" ;
RUN;


/* On a supprimé les autres pays et les religions minoritaires*/
DATA ess ;
SET ess ;
IF rlgdnm="1" OR rlgdnm="2" OR rlgdnm="3" OR rlgdnm="5" OR rlgdnm="6" OR rlgdnm="66" ;
RUN


/*on a créé une nouvelle variable religion*/
DATA ess ;
SET ess ;
LENGTH Religion $ 100 ;
IF rlgdnm="1" THEN Religion = "Catholique" ;
ELSE IF rlgdnm="2" THEN Religion = "Protestante" ;
ELSE IF rlgdnm="5" THEN Religion = "Juive" ;
ELSE IF rlgdnm="6" THEN Religion = "Musulmane" ;
ELSE IF rlgdnm="66" THEN Religion = "Sans Religion" ;
RUN;



/*on pondère*/
DATA ess ;
SET ess ;
pond = pspwght*pweight*10000 ;
RUN;


/*Gaphe1*/
DATA essvote ;
SET ess ;
IF vote="1" OR vote="2" OR vote="3" ;
RUN;
DATA essvote ;
SET essvote ;
LENGTH avote $30 ;
IF vote="1" THEN avote="Oui" ;
ELSE IF vote="2" THEN avote="Non" ;
ELSE IF vote="3" THEN avote="Pas le droit de vote" ;
RUN;


PROC SORT DATA=essvote ;
BY religion ;
RUN;


PROC FREQ DATA=essvote NOPRINT;
BY religion ;
TABLES avote / out=FreqOut ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR Religion / GROUP = avote SEGLABEL response = Percent ;
STYLEATTRS DATACOLORS=(DEYPK STYG MEGR);
RUN;


/*Graphe2*/
DATA essparti ;
SET ess ;
IF lrscale="0" OR lrscale="1" OR lrscale="2" OR lrscale="3" OR lrscale="4" OR lrscale="5" OR
lrscale="6" OR lrscale="7" OR lrscale="8" OR lrscale="9" OR lrscale="10" ;
RUN;


DATA essparti ;
SET essparti ;
LENGTH Parti $30 ;
IF lrscale IN (0,1) THEN Parti="1)Extrême Gauche" ;
ELSE IF lrscale IN (2,3,4) THEN Parti="2)Gauche" ;
ELSE IF lrscale IN (5) THEN Parti="3)Centre" ;
ELSE IF lrscale IN (6,7,8) THEN Parti="4)Droite" ;
ELSE IF lrscale IN (9,10) THEN Parti="5)Extrême Droite" ;
RUN;


PROC SORT DATA=essparti ;
BY Religion ;
RUN;


PROC FREQ DATA=essparti NOPRINT;
BY religion ;
TABLES Parti / out=FreqOut ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FreqOut ;
HBAR Religion / GROUP = Parti SEGLABEL response = Percent ;
STYLEATTRS DATACOLORS=(STR VIYPK GWH BIGB VIGB ) ;
RUN;


/*Graphe 3*/
DATA esspol ;
SET ess ;
IF polintr="1" OR polintr="2" OR polintr="3" OR polintr="4" ;
RUN;


DATA esspol ;
SET esspol ;
LENGTH Interet $30 ;
IF polintr="1" THEN Interet="4) Très intéressé" ;
ELSE IF polintr="2" THEN Interet="3) Intéressé" ;
ELSE IF polintr="3" THEN Interet="2) Peu intéressé" ;
ELSE IF polintr="4" THEN Interet="1) Pas intéressé" ;
RUN;


PROC SORT DATA=esspol ;
BY Religion ;
RUN;


PROC FREQ DATA=esspol NOPRINT;
BY religion ;
TABLES Interet / out=FreqOut ;
WEIGHT pond ;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR Religion / GROUP = Interet SEGLABEL response = Percent ;
STYLEATTRS DATACOLORS=(VIYPK LIPK MOGY VIG ) ;
RUN;


/*Graphe4*/
DATA esstru ;
SET ess ;
IF trstplt in (0,1,2,3,4,5,6,7,8,9,10) ;
RUN;


DATA esstru ;
SET esstru ;
LENGTH Confianceaveclespoliticiens$60;
IFtrstpltIN(0, 1, 2)THENConfianceenlespoliticiens = ”1)Pasconfiant”;
ELSEIFtrstpltIN(3, 4)THENConfianceenlespoliticiens = ”2)Peuconfiant”;
ELSEIFtrstpltIN(5)THENConfianceenlespoliticiens = ”3)Neutre”;
ELSEIFtrstpltIN(6, 7, 8)THENConfianceenlespoliticiens = ”4)Confiant”;
ELSEIFtrstpltIN(9, 10)THENConfianceenlespoliticiens = ”5)Trsconfiant”;
RUN;


PROC SORT DATA=esstru ;
BY Religion ;
RUN;


PROC FREQ DATA=esstru NOPRINT;
BY religion ;
TABLES Confianceenlespoliticiens/out = FreqOut;
WEIGHTpond;
RUN;


PROC SGPLOT Data=FreqOut ;
VBAR Religion / GROUP = ConfianceenlespoliticiensSEGLABELresponse = Percent;
STY LEATTRSDATACOLORS = (STRV IY PKYWHV IGSTOLG);
RUN;
