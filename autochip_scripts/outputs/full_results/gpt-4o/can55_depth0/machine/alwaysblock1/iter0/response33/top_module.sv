module top_module(
	input a, 
	input b,
	output out_assign,
	output reg out_alwaysblock
);

    // Assign statement for the first output
    assign out_assign = a & b;

    // Always block for the second output
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
