module top_module (
    input cpu_overheated,
    input shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving,
    output reg shut_off_computer_out
);

always @(*) begin
    if (cpu_overheated) 
        shut_off_computer_out = 1;
    else 
        shut_off_computer_out = 0;
end

always @(*) begin
    if (!arrived) 
        keep_driving = ~gas_tank_empty;
    else 
        keep_driving = 0;
end

endmodule
