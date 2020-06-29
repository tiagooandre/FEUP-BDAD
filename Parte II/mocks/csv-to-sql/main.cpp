#include <iostream>

#include "InsertSQL.h"

int main() {

    string filename = "../povoar.sql";

    InsertSQL insertSql(filename);
    insertSql.insertEventos();
    insertSql.insertUtilizadores();
    insertSql.insertPariculares();
    insertSql.insertProfissionais();

    insertSql.insertCondicao();
    insertSql.insertAnuncios();
    insertSql.insertVeiculos();

    insertSql.insertPecas();
    insertSql.insertCarros();
    insertSql.insertMotos();
    insertSql.insertFotos();

    insertSql.insertInteresses();
    return 0;
}
