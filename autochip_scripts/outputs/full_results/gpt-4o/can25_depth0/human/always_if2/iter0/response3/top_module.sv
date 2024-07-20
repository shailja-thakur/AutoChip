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
            shut_off_computer = 0; // Add this line to handle the case when cpu_overheated is 0
    end

    always @(*) begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 0; // Add this line to handle the case when arrived is true
    end

endmodule
