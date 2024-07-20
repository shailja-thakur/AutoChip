module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg shut_off_computer_out,
    output reg keep_driving
);

always @(*) begin
    if (cpu_overheated) begin
        shut_off_computer_out = 1;
    end else begin
        shut_off_computer_out = 0;
    end
end

always @(*) begin
    if (arrived == 0) begin
        keep_driving = ~gas_tank_empty;
    end else begin
        keep_driving = 0;
    end
end

endmodule
