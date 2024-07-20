module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

always @(*) begin
    if (do_sub == 1'b0) begin
        out = a + b; // Perform addition
    end else begin
        out = a - b; // Perform subtraction
    end

    // Set result_is_zero if the result is 0
    if (out == 8'b0) begin
        result_is_zero = 1'b1;
    end else begin
        result_is_zero = 1'b0;
    end
end

endmodule
