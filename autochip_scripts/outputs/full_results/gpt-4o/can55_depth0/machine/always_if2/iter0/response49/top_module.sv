module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer_control, // Renamed input to avoid confusion with the output
    output reg shut_off_computer,
    output reg keep_driving
);

always @(*) begin
    if (cpu_overheated)
        shut_off_computer = 1;
    else
        shut_off_computer = shut_off_computer_control; // Keep in mind the control signal 
end

always @(*) begin
    if (arrived)
        keep_driving = 0;
    else
        keep_driving = ~gas_tank_empty;
end

endmodule
