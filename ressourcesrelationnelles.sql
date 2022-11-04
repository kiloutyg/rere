-- Adminer 4.7.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categ` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `commentaire`;
CREATE TABLE `commentaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(1000) NOT NULL,
  `idPublication` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idParent` int(11) DEFAULT NULL,
  `idStatut` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idPublication` (`idPublication`),
  KEY `idUser` (`idUser`),
  KEY `idParent` (`idParent`),
  KEY `idStatut` (`idStatut`),
  CONSTRAINT `commentaire_ibfk_1` FOREIGN KEY (`idPublication`) REFERENCES `publication` (`id`),
  CONSTRAINT `commentaire_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`),
  CONSTRAINT `commentaire_ibfk_3` FOREIGN KEY (`idParent`) REFERENCES `commentaire` (`id`),
  CONSTRAINT `commentaire_ibfk_4` FOREIGN KEY (`idStatut`) REFERENCES `statut` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `etat`;
CREATE TABLE `etat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valide` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO `etat` (`id`, `valide`) VALUES
(1,	0),
(2,	1);

DROP TABLE IF EXISTS `favoris`;
CREATE TABLE `favoris` (
  `idUser` int(11) NOT NULL,
  `idPublication` int(11) NOT NULL,
  PRIMARY KEY (`idUser`,`idPublication`),
  KEY `idUser` (`idUser`),
  KEY `idPublication` (`idPublication`),
  CONSTRAINT `favoris_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`),
  CONSTRAINT `favoris_ibfk_2` FOREIGN KEY (`idPublication`) REFERENCES `publication` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `idFollower` int(11) NOT NULL,
  `idFollowed` int(11) NOT NULL,
  PRIMARY KEY (`idFollower`,`idFollowed`),
  KEY `idFollower` (`idFollower`),
  KEY `idFollowed` (`idFollowed`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`idFollower`) REFERENCES `user` (`id`),
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`idFollowed`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `idMessage` int(11) NOT NULL AUTO_INCREMENT,
  `idEmetteur` int(11) NOT NULL,
  `idDestinataire` int(11) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `pieceJointe` varchar(500) NOT NULL,
  PRIMARY KEY (`idMessage`,`idEmetteur`,`idDestinataire`),
  KEY `idMessage` (`idMessage`),
  KEY `idEmetteur` (`idEmetteur`),
  KEY `idDestinataire` (`idDestinataire`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`idEmetteur`) REFERENCES `user` (`id`),
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`idDestinataire`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `publication`;
CREATE TABLE `publication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `text` int(11) NOT NULL,
  `pieceJointe` varchar(500) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idCategorie` int(11) NOT NULL,
  `idTag` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idCategorie` (`idCategorie`),
  KEY `idUser` (`idUser`),
  KEY `idTag` (`idTag`),
  CONSTRAINT `publication_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`),
  CONSTRAINT `publication_ibfk_2` FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`),
  CONSTRAINT `publication_ibfk_3` FOREIGN KEY (`idTag`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `roles` (`id`, `role`) VALUES
(1,	'visiteur'),
(2,	'citoyen'),
(3,	'admin'),
(4,	'moderateur'),
(5,	'superAdmin');

DROP TABLE IF EXISTS `statut`;
CREATE TABLE `statut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `statut` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO `statut` (`id`, `statut`) VALUES
(1,	'nouveau'),
(2,	'valide'),
(3,	'refuse');

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `prenom` varchar(150) NOT NULL,
  `tel` char(14) NOT NULL,
  `mel` varchar(150) NOT NULL,
  `pseudo` varchar(150) NOT NULL,
  `idRole` int(11) NOT NULL,
  `idEtat` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idRole` (`idRole`),
  KEY `idEtat` (`idEtat`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`idRole`) REFERENCES `roles` (`id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`idEtat`) REFERENCES `etat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- 2022-10-07 12:37:28
