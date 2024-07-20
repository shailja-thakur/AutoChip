module top_module (
    input cpu_overheated,
    output reg shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0; // Initialize shut_off_computer to 0 when cpu is not overheated
    end

    always @(*) begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 0; // Initialize keep_driving to 0 when arrived
    end

endmodule
