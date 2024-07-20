module top_module (
    input  wire cpu_overheated,
    input  wire arrived,
    input  wire gas_tank_empty,
    input  wire shut_off_computer_in,
    output reg  shut_off_computer,
    output reg  keep_driving
);

always @(*) begin
    if (cpu_overheated)
        shut_off_computer = 1;
    else
        shut_off_computer = shut_off_computer_in;
end

always @(*) begin
    if (!arrived)
        keep_driving = ~gas_tank_empty;
    else
        keep_driving = 0;
end

endmodule
