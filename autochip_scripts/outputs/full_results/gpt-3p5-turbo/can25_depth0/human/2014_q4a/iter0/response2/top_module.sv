module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	// Internal wire declarations
	wire in;
	
	// Register declaration
	reg data;
	
	// Mux declarations
	wire mux_out;
	wire mux_out_inv;
	
	// D flip-flop
	always@(posedge clk) begin
		if (E)
			data <= w;
		else if (L)
			data <= R;
	end
	
	// Mux for selecting input to the flip-flop
	assign in = (E) ? w : R;
	assign mux_out = (L) ? R : data;
	
	// Output
	assign Q = mux_out;
endmodule
