module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    always @(cpu_overheated) begin
        if (cpu_overheated)
           shut_off_computer = 1;
    end

    always @(arrived or gas_tank_empty) begin
        if (!arrived)
           keep_driving = !gas_tank_empty;
    end

endmodule
