module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

    // Reg declareation for intermediate calculations
    reg [8:0] sum;
    
    always @(*) begin
        case (do_sub)
          0: sum = a+b; // Add the inputs
          1: sum = a-b; // Subtract the inputs
        endcase
        
        out = sum[7:0]; // Assign the lower 8 bits of sum to out
        
        result_is_zero = (sum == 0) ? 1 : 0; // Check if sum is zero and assign the result to result_is_zero
    end

endmodule
