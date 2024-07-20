module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,       // Added missing input
    output reg keep_driving,
    output reg shut_off_computer   // Moved to the proper output position
);

always @(*) begin
    if (cpu_overheated)
        shut_off_computer = 1;
    else
        shut_off_computer = 0;
end

always @(*) begin
    if (arrived == 0)
        keep_driving = ~gas_tank_empty;
    else
        keep_driving = 0;
end

endmodule
