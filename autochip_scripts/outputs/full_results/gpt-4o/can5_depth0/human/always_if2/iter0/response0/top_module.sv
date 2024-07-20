module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;  // Added to handle the case when cpu is not overheated
    end

    always @(*) begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 0;  // Added to handle the case when arrived is 1
    end

endmodule
