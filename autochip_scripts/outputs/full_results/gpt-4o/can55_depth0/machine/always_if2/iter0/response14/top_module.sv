module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer, // Changed to input
    output reg shut_off_computer_output, // Changed to different name to avoid conflict
    output reg keep_driving
);

// Always block for controlling shut_off_computer_output
always @(*) begin
    if (cpu_overheated)
        shut_off_computer_output = 1;
    else
        shut_off_computer_output = 0;
end

// Always block for controlling keep_driving
always @(*) begin
    if (!arrived)
        keep_driving = !gas_tank_empty;
    else
        keep_driving = 0;
end

endmodule
