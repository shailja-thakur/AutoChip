module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty, 
    input shut_off_computer,
    output reg keep_driving,
    output reg shut_off_computer_output
);

always @(cpu_overheated) begin
    if (cpu_overheated) begin
        shut_off_computer_output = 1;
    end else begin
        shut_off_computer_output = 0;
    end
end

always @(arrived, gas_tank_empty) begin
    if (!arrived && !gas_tank_empty) begin
        keep_driving = 1;
    end else begin
        keep_driving = 0;
    end
end

endmodule
