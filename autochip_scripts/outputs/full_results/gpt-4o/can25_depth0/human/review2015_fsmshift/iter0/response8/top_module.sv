module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b1111;
        end else if (state != 4'b0000) begin
            state <= state - 1;
        end
    end

    always @(*) begin
        if (state != 4'b0000)
            shift_ena = 1;
        else
            shift_ena = 0;
    end

endmodule
