module top_module (
    input wire cpu_overheated,
    input wire arrived,
    input wire gas_tank_empty,
    input wire shut_off,
    output reg shut_off_computer,
    output reg keep_driving
);

always @(*) begin
    if (cpu_overheated) begin
        shut_off_computer = 1;
    end else begin
        shut_off_computer = shut_off;
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
