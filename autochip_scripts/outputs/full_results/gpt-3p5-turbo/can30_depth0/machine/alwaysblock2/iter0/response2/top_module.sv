module top_module(
		    input  wire     clk,    // input port for clock signal
		    input  wire     a,      // input port for signal a
		    input  wire     b,      // input port for signal b
		    output wire     out_assign,         // output port for assign statement
		    output reg      out_always_comb,    // output port for always_comb statement
		    output reg      out_always_ff       // output port for always_ff statement
		);
		assign out_assign = a ^ b;  // logical XOR operation on input ports a and b, assigned to out_assign
		
		always_comb begin
			out_always_comb = a ^ b;  // logical XOR operation on input ports a and b, assigned to out_always_comb
		end
		
		always @(posedge clk) begin
			out_always_ff = a ^ b;  // logical XOR operation on input ports a and b, assigned to out_always_ff
		end
	endmodule
