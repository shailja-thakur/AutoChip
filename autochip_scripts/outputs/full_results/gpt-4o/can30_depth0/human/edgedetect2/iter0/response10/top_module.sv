module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

    reg [7:0] in_d;

    always @(posedge clk) begin
        in_d <= in; // Capture the input value for next comparison
        anyedge <= (in & ~in_d); // Detect 0 to 1 transitions
    end

endmodule
