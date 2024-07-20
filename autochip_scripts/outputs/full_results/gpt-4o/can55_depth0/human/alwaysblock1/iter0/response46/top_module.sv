module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

    // Implement using an assign statement
    assign out_assign = a & b;
    
    // Implement using a combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
