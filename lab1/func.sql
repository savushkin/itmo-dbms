procedure disable_not_null ( nameIn varchar2 )
as
    loopIndex INTEGER;
begin
    loopIndex := 0;

    for notNullRow in (select * from all_constraints ac where (ac.owner = upper(nameIn) and (ac.search_condition is not null) and (ac.generated = 'USER NAME'))) loop 
        DBMS_OUTPUT.PUT_LINE(notNullRow.CONSTRAINT_NAME);
--        execute immediate 'alter table ' || notNullRow.TABLE_NAME || ' disable constraint ' || notNullRow.R_CONSTRAINT_NAME;
        loopIndex := loopIndex + 1;
    end loop;

    	DBMS_OUTPUT.PUT_LINE('Схема: ' || nameIn);
    	DBMS_OUTPUT.PUT_LINE('Ограничений целостности типа NOT NULL отключено: ' || loopIndex);
end;
