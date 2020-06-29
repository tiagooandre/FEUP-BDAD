//
// Created by skidr on 03/04/2020.
//

#ifndef CSV_TO_SQL_INSERTSQL_H
#define CSV_TO_SQL_INSERTSQL_H

#include "CSVReader.h"
#include <set>

static string eventosFile = "../data/eventos.csv";
static string utilizadoresFile = "../data/utilizadores.csv";
static string particularesFile = "../data/particulares.csv";
static string profissionaisFile = "../data/profissionais.csv";
static string anunciosFile = "../data/anuncios.csv";
static string veiculosFile = "../data/veiculos.csv";
static string pecasFile = "../data/pecas.csv";
static string carrosFile = "../data/carro.csv";
static string motosFile = "../data/moto.csv";
static string fotosFile = "../data/fotos.csv";
static string delimiter = ";";

class InsertSQL {
    CSVReader* eventos;
    CSVReader* utilizadores;
    CSVReader* particulares;
    CSVReader* profissionais;
    CSVReader* anuncios;
    CSVReader* veiculos;
    CSVReader* pecas;
    CSVReader* carros;
    CSVReader* motos;
    CSVReader* fotos;
    ofstream output;

public:
    InsertSQL(string filename);

    int insertEventos();
    int insertUtilizadores();
    int insertPariculares();
    int insertProfissionais();
    int insertCondicao();
    int insertAnuncios();
    int insertVeiculos();
    int insertPecas();
    int insertCarros();
    int insertMotos();
    int insertFotos();
    int insertInteresses();
};


#endif //CSV_TO_SQL_INSERTSQL_H
