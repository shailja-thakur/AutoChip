module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] d; // D input for each flip flop
	reg [3:0] q; // Q output for each flip flop
	
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			q <= 4'b0; // Reset the output to 0
		end else begin
			q <= d; // Assign D input to Q output on positive clock edge
		end
	end
	
	assign out = q[0];
	
	always @(posedge clk) begin
		if (~resetn) begin
			d <= 4'b0; // Reset all inputs to 0
		end else begin
			d <= {d[2:0], in}; // Shift in the new input into the shift register
		end
	end
	
endmodule
