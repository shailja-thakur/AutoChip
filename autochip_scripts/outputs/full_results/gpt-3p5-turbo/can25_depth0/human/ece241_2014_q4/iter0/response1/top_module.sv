module top_module (
	input clk,
	input x,
	output z
);
	/* Define D flip-flop */
	reg d_ff0;
	reg d_ff1;
	reg d_ff2;
	
	/* Define flip-flop outputs */
	wire q_ff0;
	wire q_ff1;
	wire q_ff2;
	
	/* Define gates */
	wire gate_xor;
	wire gate_and;
	wire gate_or;
	
	/* Define XNOR gate */
	wire z_internal;
	
	/* Assign inputs to flip-flop D inputs */
	assign d_ff0 = x;
	assign d_ff1 = q_ff0;
	assign d_ff2 = ~q_ff1;
	
	/* Assign flip-flop outputs to gates */
	assign gate_xor = x ^ q_ff0;
	assign gate_and = x & ~q_ff1;
	assign gate_or = x | ~q_ff2;
	
	/* Assign XNOR gate output to Z */
	assign z_internal = gate_xor ^ gate_and ^ gate_or;
	assign z = z_internal;
	
	/* Define clock behavior */
	always @(posedge clk) begin
		q_ff0 <= d_ff0;
		q_ff1 <= d_ff1;
		q_ff2 <= d_ff2;
	end
endmodule
