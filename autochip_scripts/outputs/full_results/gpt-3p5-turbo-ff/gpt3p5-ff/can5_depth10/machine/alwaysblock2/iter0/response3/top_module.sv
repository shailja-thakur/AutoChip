module top_module(
     input clk,         // input clock
     input a,           // input signal a
     input b,           // input signal b
     output out_assign, // XOR result assigned using assign statement
     output reg out_always_comb, // XOR result assigned using always_comb block
     output reg out_always_ff    // XOR result assigned using always_ff block
);
	
	assign out_assign = a ^ b; // XOR operation using assign statement
	
	always_comb begin
		out_always_comb = a ^ b; // XOR operation using always_comb block
	end
	
	always_ff @(posedge clk) begin
		out_always_ff <= a ^ b; // XOR operation using always_ff block
	end
	
endmodule
