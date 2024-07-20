module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

    reg [7:0] in_delayed;

    always @(posedge clk) begin
        pedge <= (~in_delayed) & in; // Detecting 0 to 1 transition
        in_delayed <= in; // Store the previous state of the input
    end

endmodule
