package TZXServer::Schema::Result::Tape;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::Result';

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
    data_type => 'integer',
    is_auto_increment => 1,
};

column title     => { data_type => 'text', is_nullable => 0 };
column year      => { data_type => 'smallint', is_nullable => 1 };
column genre     => { data_type => 'text', is_nullable => 1  };
column publisher => { data_type => 'text', is_nullable => 1  };
column uri       => { data_type => 'text', is_nullable => 1  };

1;
