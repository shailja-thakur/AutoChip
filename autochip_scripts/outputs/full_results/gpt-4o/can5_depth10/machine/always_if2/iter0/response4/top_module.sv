module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg keep_driving,
    output reg shut_off_computer_o
);

always @(*) begin
    if (cpu_overheated) begin
        shut_off_computer_o = 1;
    end else begin
        shut_off_computer_o = 0;
    end
end

always @(*) begin
    if (!arrived) begin
        keep_driving = ~gas_tank_empty;
    end else begin
        keep_driving = 0;
    end
end

endmodule
