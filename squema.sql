IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Clientes] (
    [ClienteId] int NOT NULL IDENTITY,
    [Nombre] nvarchar(max) NULL,
    [Direccion] nvarchar(max) NULL,
    [Telefono] nvarchar(max) NULL,
    CONSTRAINT [PK_Clientes] PRIMARY KEY ([ClienteId])
);
GO

CREATE TABLE [TipoMovimientos] (
    [TipoMovimientoId] int NOT NULL IDENTITY,
    [Nombre] nvarchar(max) NULL,
    CONSTRAINT [PK_TipoMovimientos] PRIMARY KEY ([TipoMovimientoId])
);
GO

CREATE TABLE [Cuentas] (
    [CuentaId] int NOT NULL IDENTITY,
    [Numero] nvarchar(max) NULL,
    [Saldo] decimal(18,2) NOT NULL,
    [ClienteId] int NULL,
    CONSTRAINT [PK_Cuentas] PRIMARY KEY ([CuentaId]),
    CONSTRAINT [FK_Cuentas_Clientes_ClienteId] FOREIGN KEY ([ClienteId]) REFERENCES [Clientes] ([ClienteId]) ON DELETE NO ACTION
);
GO

CREATE TABLE [Movimientos] (
    [MovimientoId] int NOT NULL IDENTITY,
    [TipoMovimientoId] int NULL,
    [Fecha] datetime2 NOT NULL,
    [Valor] decimal(18,2) NOT NULL,
    [Saldo] decimal(18,2) NOT NULL,
    [CuentaId] int NULL,
    CONSTRAINT [PK_Movimientos] PRIMARY KEY ([MovimientoId]),
    CONSTRAINT [FK_Movimientos_Cuentas_CuentaId] FOREIGN KEY ([CuentaId]) REFERENCES [Cuentas] ([CuentaId]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Movimientos_TipoMovimientos_TipoMovimientoId] FOREIGN KEY ([TipoMovimientoId]) REFERENCES [TipoMovimientos] ([TipoMovimientoId]) ON DELETE NO ACTION
);
GO

CREATE INDEX [IX_Cuentas_ClienteId] ON [Cuentas] ([ClienteId]);
GO

CREATE INDEX [IX_Movimientos_CuentaId] ON [Movimientos] ([CuentaId]);
GO

CREATE INDEX [IX_Movimientos_TipoMovimientoId] ON [Movimientos] ([TipoMovimientoId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20211125185343_InitialMigration', N'5.0.9');
GO

COMMIT;
GO

