module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    reg [31:0] reg_in;

    always @(posedge clk) begin
        if (reset) begin
            reg_in <= 0;
            out <= 0;
        end
        else begin
            reg_in <= in;
            out <= (reg_in ^ in) & ~in;
        end
    end

endmodule
