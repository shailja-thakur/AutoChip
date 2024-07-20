module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

    always @(*) begin
        case (do_sub)
            0: out = a + b;
            1: out = a - b;
            default: out = 8'b0; // To handle any unforeseen cases, though not strictly necessary here
        endcase

        // Fixing the result_is_zero assignment
        // In Verilog, "~out" produces an 8-bit result.
        // We should compare "out" to zero directly.
        if (out == 8'b0)
            result_is_zero = 1;
        else
            result_is_zero = 0;
    end

endmodule
