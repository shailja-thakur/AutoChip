module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        pedge <= (~in_prev) & in;
        in_prev <= in;
    end

endmodule
