
CREATE SCHEMA IF NOT EXISTS `medstock` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `medstock` ;


CREATE TABLE IF NOT EXISTS `medstock`.`curso` (
  `idcurso` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`idcurso`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `prioridade` VARCHAR(20) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`idtipo_usuario`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `matricula` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(128) NOT NULL,
  `curso_idcurso` INT NOT NULL,
  `tipo_usuario_idtipo_usuario` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  CONSTRAINT `fk_usuario_curso` FOREIGN KEY (`curso_idcurso`) REFERENCES `medstock`.`curso` (`idcurso`), 
CONSTRAINT `fk_usuario_tipo_usuario1` FOREIGN KEY (`tipo_usuario_idtipo_usuario`) REFERENCES `medstock`.`tipo_usuario` (`idtipo_usuario`));
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`fabricante` (
  `idfabricante` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `nome_fantasia` VARCHAR(255) NULL,
  `descricao` VARCHAR(255) NULL,
  `cnpj` VARCHAR(20) NULL,
  PRIMARY KEY (`idfabricante`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `medstock`.`estoque` (
  `idestoque` INT NOT NULL AUTO_INCREMENT,
  `predio` SMALLINT NOT NULL,
  `sala` SMALLINT NOT NULL,
  `apelido` VARCHAR(50) NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`idestoque`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`estoque_items` (
  `idestoque_items` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
   `foto` blub,
  `quantidade` DOUBLE(10,2) NULL,
  `lote` VARCHAR(50) NULL,
  `medida` VARCHAR(100) NULL,
  `descartavel` ENUM('0','1') NOT NULL,
  `data_validade` DATETIME NULL,
  `data_fabricacao` DATETIME NULL,
  `categoria_idcategoria` INT NOT NULL,
  `fabricante_idfabricante` INT NOT NULL,
  `estoque_idestoque` INT NOT NULL,
  PRIMARY KEY (`idestoque_items`),
  INDEX `fk_estoque_categoria1_idx` (`categoria_idcategoria` ASC),
  INDEX `fk_estoque_fabricante1_idx` (`fabricante_idfabricante` ASC),
  INDEX `fk_estoque_items_estoque1_idx` (`estoque_idestoque` ASC),
  CONSTRAINT `fk_estoque_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `medstock`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_fabricante1`
    FOREIGN KEY (`fabricante_idfabricante`)
    REFERENCES `medstock`.`fabricante` (`idfabricante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_items_estoque1`
    FOREIGN KEY (`estoque_idestoque`)
    REFERENCES `medstock`.`estoque` (`idestoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`tipo_emprestimo` (
  `idtipo_emprestimo` INT NOT NULL AUTO_INCREMENT,
  `tipo_emprestimo` VARCHAR(50) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`idtipo_emprestimo`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`emprestimo` (
  `idemprestimo` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `data_emprestimo` DATETIME NOT NULL,
  `data_devolucao` DATETIME NOT NULL,
  `tipo_emprestimo_idtipo_emprestimo` INT NOT NULL,
  PRIMARY KEY (`idemprestimo`),
  INDEX `fk_emprestimo_usuario1_idx` (`usuario_idusuario` ASC),
  INDEX `fk_emprestimo_tipo_emprestimo1_idx` (`tipo_emprestimo_idtipo_emprestimo` ASC),
  CONSTRAINT `fk_emprestimo_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `medstock`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emprestimo_tipo_emprestimo1`
    FOREIGN KEY (`tipo_emprestimo_idtipo_emprestimo`)
    REFERENCES `medstock`.`tipo_emprestimo` (`idtipo_emprestimo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`emprestimo_has_estoque_items` (
  `emprestimo_idemprestimo_items` INT NOT NULL,
  `estoque_idestoque` INT NOT NULL,
  `quantidade` DOUBLE(10,2) NOT NULL,
  `data_emprestimo` DATETIME NOT NULL,
  PRIMARY KEY (`emprestimo_idemprestimo_items`, `estoque_idestoque`),
  INDEX `fk_emprestimo_has_estoque_estoque1_idx` (`estoque_idestoque` ASC),
  INDEX `fk_emprestimo_has_estoque_emprestimo1_idx` (`emprestimo_idemprestimo_items` ASC),
  CONSTRAINT `fk_emprestimo_has_estoque_emprestimo1`
    FOREIGN KEY (`emprestimo_idemprestimo_items`)
    REFERENCES `medstock`.`emprestimo` (`idemprestimo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emprestimo_has_estoque_estoque1`
    FOREIGN KEY (`estoque_idestoque`)
    REFERENCES `medstock`.`estoque_items` (`idestoque_items`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `medstock`.`solicitacao_compra` (
  `idsolicitacao_compra` INT NOT NULL AUTO_INCREMENT,
  `data_solicitacao` DATETIME NOT NULL,
  `data_entrega` DATETIME NOT NULL,
  `descricao` TEXT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idsolicitacao_compra`),
  INDEX `fk_solicitacao_compra_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_solicitacao_compra_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `medstock`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `medstock`.`solicitacao_compra_has_estoque_items` (
  `solicitacao_compra_idsolicitacao_compra` INT NOT NULL,
  `estoque_items_idestoque_items` INT NOT NULL,
  `data_solicitacao` DATETIME NOT NULL,
  `quantidade` DOUBLE(10,2) NOT NULL,
  PRIMARY KEY (`solicitacao_compra_idsolicitacao_compra`, `estoque_items_idestoque_items`),
  INDEX `fk_solicitacao_compra_has_estoque_items_estoque_items1_idx` (`estoque_items_idestoque_items` ASC),
  INDEX `fk_solicitacao_compra_has_estoque_items_solicitacao_compra1_idx` (`solicitacao_compra_idsolicitacao_compra` ASC),
  CONSTRAINT `fk_solicitacao_compra_has_estoque_items_solicitacao_compra1`
    FOREIGN KEY (`solicitacao_compra_idsolicitacao_compra`)
    REFERENCES `medstock`.`solicitacao_compra` (`idsolicitacao_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitacao_compra_has_estoque_items_estoque_items1`
    FOREIGN KEY (`estoque_items_idestoque_items`)
    REFERENCES `medstock`.`estoque_items` (`idestoque_items`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

