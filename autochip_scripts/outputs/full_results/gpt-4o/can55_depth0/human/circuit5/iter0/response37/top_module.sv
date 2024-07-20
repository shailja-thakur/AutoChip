module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
    
    // Declare the 4-bit output based on the pattern from the waveform
    always @(*) begin
        case (c)
            4'd0: q = b;  // if c == 0 then q = b
            4'd1: q = e;  // if c == 1 then q = e
            4'd2: q = a;  // if c == 2 then q = a
            4'd3: q = d;  // if c == 3 then q = d
            default: q = 4'hf;  // for other values of c, q = f (15 for 4-bits)
        endcase
    end

endmodule
