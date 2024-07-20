module top_module (
	input wire clk,
	input wire d,
	input wire r,
	output wire q
);

	reg q;  // output register

	always @(posedge clk) begin  // triggered on rising edge of clock
		if (r) begin  // reset is active
			q <= 0;  // output set to 0
		end else begin
			q <= d;  // output set to data input value
		end
	end

endmodule
