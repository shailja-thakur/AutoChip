module top_module (
    input  cpu_overheated,
    output reg shut_off_computer,
    input  arrived,
    input  gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        if (cpu_overheated) begin
            shut_off_computer = 1'b1;
        end else begin
            shut_off_computer = 1'b0;
        end
    end

    always @(*) begin
        if (arrived) begin
            keep_driving = 1'b0;
        end else begin
            keep_driving = ~gas_tank_empty;
        end
    end

endmodule
