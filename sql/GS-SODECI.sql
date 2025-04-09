CREATE TABLE IF NOT EXISTS `Activite` (
  `id` varchar(255) PRIMARY KEY,
  `codeact` varchar(255) UNIQUE,
  `libact` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Agent` (
  `id` varchar(255) PRIMARY KEY,
  `matricule` varchar(255),
  `nom` varchar(255),
  `prenom` varchar(255),
  `numCNPS` varchar(255),
  `localisation` varchar(255),
  `email` varchar(255),
  `codeSociete` varchar(255),
  `exploitation` varchar(255),
  `adresse` varchar(255),
  `codeStatut` varchar(255),
  `lastUser` varchar(255),
  `lastDate` varchar(255),
  `telephone` varchar(255),
  `nomReseau` varchar(255),
  `codeCategorieAgent` varchar(255),
  `codeZoneIntervention` varchar(255),
  `codeFonctionAgent` varchar(255),
  `isResponsableCI` boolean,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Approvisionnement` (
  `id` varchar(255) PRIMARY KEY,
  `caisse` varchar(255),
  `userid` varchar(255),
  `beneficiaireId` varchar(255),
  `numeroBon` varchar(255),
  `montant` decimal,
  `motif` varchar(255),
  `status` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Attribution` (
  `id` varchar(255) PRIMARY KEY,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `AttributionCaisse` (
  `id` varchar(255) PRIMARY KEY,
  `caisse` varchar(255),
  `attributionId` varchar(255),
  `status` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `BonMission` (
  `id` varchar(255) PRIMARY KEY,
  `numeroBon` varchar(255) UNIQUE,
  `motif` varchar(255),
  `serviceEmetteur` varchar(255),
  `beneficiaireId` varchar(255),
  `matricule` varchar(255),
  `nom` varchar(255),
  `zoneIntervention` varchar(255),
  `mandataire` boolean,
  `emetteur` varchar(255),
  `typeMission` varchar(255),
  `moyenTransport` varchar(255),
  `ordonnateurMission` varchar(255),
  `dateDepart` datetime,
  `dateArrivee` datetime,
  `itineraireMultiple` boolean,
  `status` varchar(255),
  `depart` varchar(255),
  `arrivee` varchar(255),
  `itineraireId` varchar(255),
  `typeCarburant` varchar(255),
  `tauxKilometrique` integer,
  `complementKilometrique` integer,
  `distanceCalculee` integer,
  `indemniteKilometrique` integer,
  `tarifsTransportCommun` integer,
  `complementTransport` integer,
  `fraisDeplacement` integer,
  `nombreRepas` integer,
  `nombreNuitees` integer,
  `prixRestauration` decimal,
  `prixHebergement` decimal,
  `montantRestauration` decimal,
  `totalOrdreMission` decimal,
  `exploitation` varchar(255),
  `activite` varchar(255),
  `indiceTiers` varchar(255),
  `codePartenaire` varchar(255),
  `pieceJointe` varchar(255),
  `texteAnnexe` varchar(255),
  `justify` boolean,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Caisse` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `lieu` varchar(255),
  `posteId` varchar(255),
  `userId` varchar(255),
  `status` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `ConfigurationSchema` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Delegation` (
  `id` varchar(255) PRIMARY KEY,
  `dateDebut` date,
  `dateFin` date,
  `delegateTo` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `CategorieAgent` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255) UNIQUE,
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `CentreImputation` (
  `id` varchar(255) PRIMARY KEY,
  `codeci` varchar(255),
  `libci` varchar(255),
  `codeEntite` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Compte` (
  `id` varchar(255) PRIMARY KEY,
  `numero` varchar(255),
  `libelle` varchar(255),
  `status` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `DepartArrive` (
  `id` varchar(255) PRIMARY KEY,
  `codeItineraire` varchar(255),
  `libelleItineraire` varchar(255),
  `codeDepart` varchar(255),
  `codeArrive` varchar(255),
  `codeTypeDepart` varchar(255),
  `codeTypeArrivee` varchar(255),
  `typeMission` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Fonction` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `GrilleFrais` (
  `id` varchar(255) PRIMARY KEY,
  `codeCategorieAgent` varchar(255),
  `codeTypeFrais` integer,
  `montant` decimal,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `GrilleKilometrique` (
  `id` varchar(255) PRIMARY KEY,
  `codeFonction` varchar(255),
  `codeTypeCarburant` varchar(255),
  `valeurTauxKm` integer,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `ItineraireDistance` (
  `id` varchar(255) PRIMARY KEY,
  `codeItineraire` varchar(255),
  `matricule` varchar(255),
  `distance` decimal,
  `enVigueur` decimal,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Justification` (
  `id` varchar(255) PRIMARY KEY,
  `numeroBon` varchar(255),
  `dateDepart` date,
  `dateArrivee` date,
  `urlPJ` varchar(255),
  `late` boolean,
  `limitDate` date,
  `status` varchar(255),
  `organisationId` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `MoyenTransport` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255) UNIQUE,
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Nature` (
  `id` varchar(255) PRIMARY KEY,
  `status` varchar(255),
  `libelle` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Numbon` (
  `id` varchar(255) PRIMARY KEY,
  `prefix` varchar(255),
  `isUsed` boolean,
  `numeroBon` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Organisation` (
  `id` varchar(255) PRIMARY KEY,
  `name` varchar(255),
  `status` varchar(255),
  `userId` varchar(255),
  `societyId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Poste` (
  `id` varchar(255) PRIMARY KEY,
  `libelle` varchar(255),
  `adresseip` varchar(255),
  `status` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Profile` (
  `id` varchar(255) PRIMARY KEY,
  `isDefault` boolean,
  `organisationId` varchar(255),
  `role` varchar(255)
);
CREATE TABLE IF NOT EXISTS `Reversement` (
  `id` varchar(255) PRIMARY KEY,
  `caisseId` varchar(255),
  `userId` varchar(255),
  `beneficiaireId` varchar(255),
  `numeroBon` varchar(255),
  `montant` decimal,
  `motif` varchar(255),
  `dateReversement` date,
  `typeReversement` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Role` (
  `id` varchar(255) PRIMARY KEY,
  `name` varchar(255),
  `status` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `SchemaComptable` (
  `id` varchar(255) PRIMARY KEY,
  `configurationId` varchar(255),
  `libelle` varchar(255),
  `status` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Societe` (
  `id` varchar(255) PRIMARY KEY,
  `slug` varchar(255),
  `name` varchar(255),
  `code` varchar(255) UNIQUE,
  `status` varchar(255),
  `userId` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `TypeCarburant` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `TypeFrais` (
  `id` varchar(255) PRIMARY KEY,
  `code` integer UNIQUE,
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `TypeMission` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `User` (
  `id` varchar(255) PRIMARY KEY,
  `email` varchar(255),
  `firstname` varchar(255),
  `lastname` varchar(255),
  `matricule` varchar(255),
  `status` varchar(255),
  `role` varchar(255),
  `isEmailConfirmed` boolean,
  `profileId` varchar(255),
  `userId` varchar(255),
  `lastLoginDate` timestamp DEFAULT CURRENT_TIMESTAMP,
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `UserPriority` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `Ville` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `codePays` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
CREATE TABLE IF NOT EXISTS `ZoneIntervention` (
  `id` varchar(255) PRIMARY KEY,
  `code` varchar(255),
  `libelle` varchar(255),
  `typeLieu` varchar(255),
  `createdAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp ON UPDATE CURRENT_TIMESTAMP,
  `__v` integer DEFAULT 0
);
ALTER TABLE `Agent`
ADD FOREIGN KEY (`codeSociete`) REFERENCES `Societe` (`code`);
ALTER TABLE `Agent`
ADD FOREIGN KEY (`codeCategorieAgent`) REFERENCES `CategorieAgent` (`code`);
ALTER TABLE `Approvisionnement`
ADD FOREIGN KEY (`caisse`) REFERENCES `Caisse` (`id`);
ALTER TABLE `Approvisionnement`
ADD FOREIGN KEY (`userid`) REFERENCES `User` (`id`);
ALTER TABLE `Approvisionnement`
ADD FOREIGN KEY (`beneficiaireId`) REFERENCES `Agent` (`id`);
ALTER TABLE `AttributionCaisse`
ADD FOREIGN KEY (`caisse`) REFERENCES `Caisse` (`id`);
ALTER TABLE `AttributionCaisse`
ADD FOREIGN KEY (`attributionId`) REFERENCES `Attribution` (`id`);
ALTER TABLE `AttributionCaisse`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `BonMission`
ADD FOREIGN KEY (`beneficiaireId`) REFERENCES `Agent` (`id`);
ALTER TABLE `BonMission`
ADD FOREIGN KEY (`emetteur`) REFERENCES `Agent` (`id`);
ALTER TABLE `BonMission`
ADD FOREIGN KEY (`moyenTransport`) REFERENCES `MoyenTransport` (`code`);
ALTER TABLE `Caisse`
ADD FOREIGN KEY (`posteId`) REFERENCES `Poste` (`id`);
ALTER TABLE `Caisse`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Delegation`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Compte`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `GrilleFrais`
ADD FOREIGN KEY (`codeCategorieAgent`) REFERENCES `CategorieAgent` (`code`);
ALTER TABLE `GrilleFrais`
ADD FOREIGN KEY (`codeTypeFrais`) REFERENCES `TypeFrais` (`code`);
ALTER TABLE `Justification`
ADD FOREIGN KEY (`numeroBon`) REFERENCES `BonMission` (`numeroBon`);
ALTER TABLE `Justification`
ADD FOREIGN KEY (`organisationId`) REFERENCES `Organisation` (`id`);
ALTER TABLE `Justification`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Nature`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Organisation`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Organisation`
ADD FOREIGN KEY (`societyId`) REFERENCES `Societe` (`id`);
ALTER TABLE `Poste`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Profile`
ADD FOREIGN KEY (`organisationId`) REFERENCES `Organisation` (`id`);
ALTER TABLE `Profile`
ADD FOREIGN KEY (`role`) REFERENCES `Role` (`id`);
ALTER TABLE `Reversement`
ADD FOREIGN KEY (`caisseId`) REFERENCES `Caisse` (`id`);
ALTER TABLE `Reversement`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Reversement`
ADD FOREIGN KEY (`beneficiaireId`) REFERENCES `Agent` (`id`);
ALTER TABLE `SchemaComptable`
ADD FOREIGN KEY (`configurationId`) REFERENCES `ConfigurationSchema` (`id`);
ALTER TABLE `SchemaComptable`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `Societe`
ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);
ALTER TABLE `User`
ADD FOREIGN KEY (`profileId`) REFERENCES `Profile` (`id`);
-- ALTER TABLE `User`
-- ADD FOREIGN KEY (`userId`) REFERENCES `User` (`id`);