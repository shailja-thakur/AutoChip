module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

    // Define the behavior of the circuit by looking up the output q based on input a
    always @(*) begin
        case(a)
            3'd0: q = 16'h1232;  // When a is 0, q is 1232
            3'd1: q = 16'haee0;  // When a is 1, q is aee0
            3'd2: q = 16'h27d4;  // When a is 2, q is 27d4
            3'd3: q = 16'h5a0e;  // When a is 3, q is 5a0e
            3'd4: q = 16'h2066;  // When a is 4, q is 2066
            3'd5: q = 16'h64ce;  // When a is 5, q is 64ce
            3'd6: q = 16'hc526;  // When a is 6, q is c526
            3'd7: q = 16'h2f19;  // When a is 7, q is 2f19
            default: q = 16'h0000; // Default case to handle unforeseen scenarios
        endcase
    end

endmodule
