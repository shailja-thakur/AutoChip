module top_module (
    input cpu_overheated,
    input arrived,
    input gas_tank_empty,
    input shut_off_computer, // should be an output
    output reg keep_driving,
    output reg shut_off_computer // repositioning shut_off_computer here
);

always @* begin
    if (cpu_overheated) begin
        shut_off_computer = 1;
    end else begin
        shut_off_computer = 0;
    end
end

always @* begin
    if (arrived == 0) begin
        keep_driving = ~gas_tank_empty;
    end else begin
        keep_driving = 0;
    end
end

endmodule
