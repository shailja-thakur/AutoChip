module top_module(
    input clk,
    input d,
    output reg q
);

	// Initialize register signal q to 1'hx
	reg [0:0] q;
	initial begin
		q = 1'hx;
	end

	// Assign value of data signal d to register signal q on rising edge of clock signal
	always @(posedge clk) begin
		q <= d;
	end

endmodule
