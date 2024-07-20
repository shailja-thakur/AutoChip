module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg keep_driving,
    output reg shut_off_computer_output
);

always @(cpu_overheated)
begin
    if (cpu_overheated)
        shut_off_computer_output = 1;
    else
        shut_off_computer_output = 0;
end

always @(arrived, gas_tank_empty)
begin
    if (!arrived)
        keep_driving = !gas_tank_empty;
    else
        keep_driving = 0;
end

assign shut_off_computer = shut_off_computer_output;

endmodule
