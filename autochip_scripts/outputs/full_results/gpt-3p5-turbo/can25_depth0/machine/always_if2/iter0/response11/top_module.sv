module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg keep_driving,
    output reg shut_off_computer
);

    always @(cpu_overheated)   // always block for "shut_off_computer" output
    begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;
    end

    always @(arrived, gas_tank_empty)   // always block for "keep_driving" output
    begin
        if (!arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 0;
    end

endmodule
