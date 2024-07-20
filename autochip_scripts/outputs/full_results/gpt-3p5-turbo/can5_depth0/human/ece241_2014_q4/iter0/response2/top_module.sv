module top_module (
	input clk,
	input x,
	output z
);
	// Define D flip-flop
	reg d1, d2, d3;
	
	// Define flip-flop outputs
	wire q1, q2, q3;
	
	// Define intermediate signals
	wire xor_out, and_out, or_out;
	
	// Define output signal
	assign z = ~xor_out;
	
	// Assign flip-flop inputs based on x and q
	always @(posedge clk) begin
		if (x) begin
			d1 <= q1;
			d2 <= ~q2;
			d3 <= ~q3;
		end else begin
			d1 <= ~q1;
			d2 <= q2;
			d3 <= q3;
		end
	end
	
	// Define XOR gate
	xor #(1) xor1 (.a(x), .b(q1), .z(xor_out));
	
	// Define AND gate
	and #(1) and1 (.a(x), .b(~q2), .z(and_out));
	
	// Define OR gate
	or #(1) or1 (.a(x), .b(~q3), .z(or_out));
	
	// Define XNOR gate
	xnor #(3) xnor1 (.a(3'b0), .b(d1, d2, d3), .z(z));
endmodule
