module top_module (
    input cpu_overheated,
    output reg shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving
);

    // Fix the always block for shut_off_computer
    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;
    end

    // Fix the always block for keep_driving
    always @(*) begin
        if (arrived)
            keep_driving = 0;
        else
            keep_driving = ~gas_tank_empty;
    end

endmodule
