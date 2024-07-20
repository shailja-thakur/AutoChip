module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer_input, // Renaming to avoid conflict with output
    output reg shut_off_computer,
    output reg keep_driving
);

always @ (cpu_overheated) begin
    if (cpu_overheated)
        shut_off_computer = 1;
    else
        shut_off_computer = 0;
end

always @ (arrived or gas_tank_empty) begin
    if (arrived == 0)
        keep_driving = ~gas_tank_empty;
    else
        keep_driving = 0;
end

endmodule
