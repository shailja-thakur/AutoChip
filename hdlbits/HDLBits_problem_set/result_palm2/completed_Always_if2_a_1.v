module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    state_machine state_machine (
        input      cpu_overheated,
        input      arrived,
        input      gas_tank_empty,
        output reg shut_off_computer,
        output reg keep_driving  );

endmodule