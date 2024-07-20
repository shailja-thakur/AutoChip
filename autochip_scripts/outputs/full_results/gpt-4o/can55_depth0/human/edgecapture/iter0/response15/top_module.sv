module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

    reg [31:0] in_reg;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'd0;
            in_reg <= 32'd0;
        end
        else begin
            out <= out | (in_reg & ~in);
            in_reg <= in;
        end
    end

endmodule
