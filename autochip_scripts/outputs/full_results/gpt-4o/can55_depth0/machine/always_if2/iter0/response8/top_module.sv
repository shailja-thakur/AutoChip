module top_module (
    input cpu_overheated,
    input shut_off_computer,
    input arrived,
    input gas_tank_empty,
    output reg keep_driving,
    output reg shut_off_computer_out
);

always @(*) begin
    if (cpu_overheated) begin
        shut_off_computer_out = 1;
    end else begin
        shut_off_computer_out = 0;
    end
end

always @(*) begin
    if (!arrived) begin
        keep_driving = !gas_tank_empty;
    end else begin
        keep_driving = 0;
    end
end

endmodule
