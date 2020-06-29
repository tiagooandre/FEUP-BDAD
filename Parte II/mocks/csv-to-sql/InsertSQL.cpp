//
// Created by skidr on 03/04/2020.
//

#include "InsertSQL.h"
#define separator ", "

string quotes(string s) {
    return "'" + s + "'";
}

InsertSQL::InsertSQL(string filename) {
    this->eventos = new CSVReader(eventosFile, delimiter);
    this->utilizadores = new CSVReader(utilizadoresFile, delimiter);
    this->profissionais = new CSVReader(profissionaisFile, delimiter);
    this->particulares = new CSVReader(particularesFile, delimiter);
    this->anuncios = new CSVReader(anunciosFile, delimiter);
    this->veiculos = new CSVReader(veiculosFile, delimiter);
    this->pecas = new CSVReader(pecasFile, delimiter);
    this->carros = new CSVReader(carrosFile, delimiter);
    this->motos = new CSVReader(motosFile, delimiter);
    this->fotos = new CSVReader(fotosFile, delimiter);

    this->output = ofstream(filename, ofstream::out | ofstream::trunc);
}

int InsertSQL::insertEventos() {
    auto data = this->eventos->getData();

    this->output << "-- Povoar Eventos\n\n";

    for (auto line : data) {
        this->output << "INSERT INTO Evento(ano, nome, desconto)\n\tVALUES(";
        this->output << line[0] << separator << quotes(line[1]) << separator << line[2] << ");" << endl;
    }

    this->output << endl << endl;
}

int InsertSQL::insertUtilizadores() {
    auto data = this->utilizadores->getData();

    this->output << "-- Povoar Utilizadores\n\n";

    for (auto line : data) {
        this->output << "INSERT INTO Utilizador(email, nome, evento, telefone)\n\tVALUES(";
        this->output << quotes(line[0]) << separator << quotes(line[1]) << separator << line[2] << separator << quotes(line[3]) << ");" << endl;
    }

    this->output << endl << endl;
}

int InsertSQL::insertPariculares() {
    auto data = this->particulares->getData();

    this->output << "-- Povoar Utilizadores Particulares\n\n";

    for (auto line : data) {
        this->output << "INSERT INTO UtilizadorParticular(email)\n\tVALUES(";
        this->output << quotes(line[0]) << ");" << endl;
    }

    this->output << endl << endl;
}

int InsertSQL::insertProfissionais() {
    auto data = this->profissionais->getData();

    this->output << "-- Povoar Utilizadores Profissionais\n\n";

    for (auto line : data) {
        this->output << "INSERT INTO UtilizadorProfissional(email, nif, localizacao, avatar)\n\tVALUES(";
        this->output << quotes(line[0]) << separator << quotes(line[1]) << separator << quotes(line[2]) << separator << quotes(line[3]) << ");" << endl;
    }

    this->output << endl << endl;
}


int InsertSQL::insertCondicao() {
    vector<string> data = {"new", "used", "semi-new"};

    this->output << "-- Povoar Condição\n\n";

    for (auto s : data) {
        this->output << "INSERT INTO Condicao(tipo)\n\tVALUES(";
        this->output << quotes(s) << ");" << endl;
    }

    this->output << endl << endl;
}


int InsertSQL::insertAnuncios() {
    auto data = this->anuncios->getData();

    this->output << "-- Povoar Anuncios\n\n";

    for (auto line : data) {
        this->output << "INSERT INTO Anuncio(id, preco, data, condicao, anunciante, evento, descricao)\n\tVALUES(";
        this->output << line[0] << separator << line[1] << separator << quotes(line[2]) << separator << quotes(line[3]) << separator << quotes(line[4]) << separator << line[5] << separator << quotes(line[6]) << ");" << endl;
    }

    this->output << endl << endl;
}

int InsertSQL::insertVeiculos() {
    vector<string> segmento = {"city", "coupe", "moto", "sedan", "suv", "utility", "van"};
    this->output << "-- Povoar Segmento\n\n";
    for (auto s : segmento) {
        this->output << "INSERT INTO Segmento(tipo)\n\tVALUES(";
        this->output << quotes(s) << ");" << endl;
    }
    this->output << endl << endl;

    auto data = this->veiculos->getData();
    set<string> marcas;
    for (auto v : data) {
        marcas.insert(v[7]);
    }
    this->output << "-- Povoar Marcas Veiculos\n\n";
    for (auto s : marcas) {
        this->output << "INSERT INTO MarcaVeiculo(nome)\n\tVALUES(";
        this->output << quotes(s) << ");" << endl;
    }
    this->output << endl << endl;

    set<vector<string>> modelos;
    for (auto v : data) {
        modelos.insert({v[7], v[8], v[9], v[10], v[12]});
    }
    this->output << "-- Povoar Modelos Veiculos\n\n";
    for (auto s : modelos) {
        this->output << "INSERT INTO ModeloVeiculo(marca, nome, potencia, cilindrada, segmento)\n\tVALUES(";
        this->output << quotes(s[0]) << separator << quotes(s[1]) << separator << s[2] << separator << s[3] << separator << quotes(s[4]) << ");" << endl;
    }
    this->output << endl << endl;

    set<vector<string>> cores;
    for (auto v : data) {
        cores.insert({v[11]});
    }
    this->output << "-- Povoar Cores\n\n";
    for (auto s : cores) {
        this->output << "INSERT INTO Cor(nome)\n\tVALUES(";
        this->output << quotes(s[0]) << ");" << endl;
    }
    this->output << endl << endl;

    set<vector<string>> registos;
    for (auto v : data) {
        registos.insert({v[13], v[14]});
    }
    this->output << "-- Povoar Registo\n\n";
    for (auto s : registos) {
        this->output << "INSERT INTO Registo(ano, mes)\n\tVALUES(";
        this->output << s[0] << separator << s[1] << ");" << endl;
    }
    this->output << endl << endl;

    this->output << "-- Povoar Veiculos\n\n";

    for (auto line : data) {
        this->output << "INSERT INTO Veiculo(id, matricula, quilometros, ivaDedutivel, retoma, financiamento, numRegistos, modelo, potencia, cilindrada, cor, segmento, anoRegisto, mesRegisto)\n\tVALUES(";
        this->output << line[0] << separator << quotes(line[1]) << separator << line[2] << separator << line[3] << separator << line[4] << separator
                    << line[5] << separator << line[6] << separator << quotes(line[8]) << separator
                    << line[9] << separator << line[10] << separator << quotes(line[11]) << separator << quotes(line[12]) << separator
                    << line[13] << separator << line[14] << ");" << endl;
    }

    this->output << endl << endl;
}

int InsertSQL::insertPecas() {
    auto data = this->pecas->getData();

    set<string> marcas;
    for (auto v : data) {
        marcas.insert(v[1]);
    }
    this->output << "-- Povoar Marcas Peças\n\n";
    for (auto s : marcas) {
        this->output << "INSERT INTO MarcaPeca(nome)\n\tVALUES(";
        this->output << quotes(s) << ");" << endl;
    }
    this->output << endl << endl;

    set<string> categorias;
    for (auto v : data) {
        categorias.insert(v[2]);
    }
    this->output << "-- Povoar Categorias Peças\n\n";
    for (auto s : categorias) {
        this->output << "INSERT INTO CategoriaPeca(nome)\n\tVALUES(";
        this->output << quotes(s) << ");" << endl;
    }
    this->output << endl << endl;

    this->output << "-- Povoar Peças\n\n";
    for (auto line : data) {
        this->output << "INSERT INTO Peca(id, marca, categoria)\n\tVALUES(";
        this->output << line[0] << separator << quotes(line[1]) << separator << quotes(line[2]) << ");" << endl;
    }
    this->output << endl << endl;
}

int InsertSQL::insertCarros() {
    auto data = this->carros->getData();

    set<vector<string>> caixas;
    for (auto v : data) {
        caixas.insert({v[6], v[7]});
    }
    this->output << "-- Povoar Caixa de Velocidades\n\n";
    for (auto s : caixas) {
        this->output << "INSERT INTO CaixaVelocidades(tipo, numVelocidades)\n\tVALUES(";
        this->output << quotes(s[0]) << separator << s[1] << ");" << endl;
    }
    this->output << endl << endl;

    set<vector<string>> tracao;
    for (auto v : data) {
        tracao.insert({v[5]});
    }
    this->output << "-- Povoar Tração\n\n";
    for (auto s : tracao) {
        this->output << "INSERT INTO Tracao(tipo)\n\tVALUES(";
        this->output << quotes(s[0]) << ");" << endl;
    }
    this->output << endl << endl;

    set<vector<string>> fuel;
    for (auto v : data) {
        fuel.insert({v[8]});
    }
    this->output << "-- Povoar Combustivel\n\n";
    for (auto s : fuel) {
        this->output << "INSERT INTO Combustivel(tipo)\n\tVALUES(";
        this->output << quotes(s[0]) << ");" << endl;
    }
    this->output << endl << endl;

    this->output << "-- Povoar Carros\n\n";
    for (auto line : data) {
        this->output << "INSERT INTO Carro(id, lotacao, classe, numPortas, importado, tracao, tipoCaixa, numVelocidades, combustivel)\n\tVALUES(";
        this->output << line[0] << separator << line[1] << separator << quotes(line[2]) << separator << line[3] << separator << line[4] << separator
                    << quotes(line[5]) << separator << quotes(line[6]) << separator << line[7] << separator << quotes(line[8]) << ");" << endl;
    }
    this->output << endl << endl;
}

int InsertSQL::insertMotos() {
    auto data = this->motos->getData();

    this->output << "-- Povoar Motos\n\n";
    for (auto line : data) {
        this->output << "INSERT INTO Moto(id)\n\tVALUES(";
        this->output << line[0] << ");" << endl;
    }
    this->output << endl << endl;
}

int InsertSQL::insertFotos() {
    auto data = this->fotos->getData();

    this->output << "-- Povoar Fotos\n\n";
    for (auto line : data) {
        this->output << "INSERT INTO Foto(link, idAnuncio)\n\tVALUES(";
        this->output << quotes(line[0]) << separator << line[1] << ");" << endl;
    }
    this->output << endl;
}

int InsertSQL::insertInteresses() {
    auto anuncios = new CSVReader(anunciosFile, delimiter);
    auto utilizadores = new CSVReader(utilizadoresFile, delimiter);

    auto data = anuncios->getData();
    set<vector<string>> ids;
    for (auto v : data)
        ids.insert({v[0], v[4]});

    data = utilizadores->getData();
    vector<string> emails;
    for (auto v : data)
        emails.push_back(v[0]);

    vector<vector<string>> toInsert;
    for (auto v : ids) {
        int num = rand() % 3;
        for (int i = 0; i < num; i++) {
            int j = 0;
            string email;
            do {
                j = rand() % emails.size();
                email = emails[j];
            } while (email == v[1]);
            string id = v[0];
            toInsert.push_back({email, id});
        }
    }

    this->output << "-- Povoar Interesses\n\n";
    for (auto line : toInsert) {
        this->output << "INSERT INTO Interessado(email, id)\n\tVALUES(";
        this->output << quotes(line[0]) << separator << line[1] << ");" << endl;
    }
    this->output << endl;
}





