module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer_ctrl,
    output reg shut_off_computer,
    output reg keep_driving
);

    // Always block to control the shut_off_computer output
    always @(*) begin
        if (cpu_overheated) 
            shut_off_computer = 1;
        else 
            shut_off_computer = 0;
    end

    // Always block to control the keep_driving output
    always @(*) begin
        if (arrived) 
            keep_driving = 0;
        else 
            keep_driving = ~gas_tank_empty;
    end

endmodule
