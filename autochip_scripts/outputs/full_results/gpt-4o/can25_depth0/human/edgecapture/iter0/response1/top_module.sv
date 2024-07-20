module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

    reg [31:0] in_last;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            in_last <= 32'b0;
        end else begin
            // Check for transition from 1 to 0
            out <= out | (in_last & ~in);
            in_last <= in;
        end
    end

endmodule
