module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    
	// Initialization of output
	initial begin
		q = 8'h0;
	end
	
	// Register behavior
	always @(posedge clk) begin
		q <= d;
	end

endmodule
