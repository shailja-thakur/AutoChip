module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
); 

  always @(*) begin
    // Perform addition or subtraction based on do_sub signal
    case (do_sub)
      0: out = a + b; // addition
      1: out = a - b; // subtraction
      default: out = 8'b0; // default case
    endcase
    
    // Set result_is_zero output
    if (out == 8'b0) begin
      result_is_zero = 1;
    end else begin
      result_is_zero = 0;
    end
    
  end
  
endmodule
