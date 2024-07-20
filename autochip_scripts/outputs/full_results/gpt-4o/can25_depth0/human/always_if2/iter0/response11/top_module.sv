module top_module (
    input cpu_overheated,
    output reg shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving
);

    // Check if the CPU is overheated
    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;  // Resetting the value when not overheated
    end

    // Determine whether to keep driving
    always @(*) begin
        if (!arrived)
            keep_driving = !gas_tank_empty;
        else
            keep_driving = 0;  // Resetting the value when arrived
    end

endmodule
