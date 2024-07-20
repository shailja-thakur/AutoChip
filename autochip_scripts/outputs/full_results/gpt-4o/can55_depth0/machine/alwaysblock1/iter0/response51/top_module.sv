module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

    // Generating out_assign using assign statement
    assign out_assign = a & b;
    
    // Generating out_alwaysblock using always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
