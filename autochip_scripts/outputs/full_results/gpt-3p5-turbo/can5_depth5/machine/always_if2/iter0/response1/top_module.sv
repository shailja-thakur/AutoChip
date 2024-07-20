module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer,
    output reg[1:0] keep_driving,
    output reg shut_off_computer
);

always @(cpu_overheated) begin
    if (cpu_overheated == 1'b1) begin
        shut_off_computer <= 1'b1;
    end else begin
        shut_off_computer <= 1'b0;
    end
end

always @(arrived, gas_tank_empty) begin
    if (arrived == 1'b0) begin
        keep_driving <= ~gas_tank_empty;
    end else begin
        keep_driving <= 1'b0;
    end
end

endmodule
