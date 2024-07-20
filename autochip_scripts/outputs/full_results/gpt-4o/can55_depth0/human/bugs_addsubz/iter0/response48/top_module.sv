module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        // Compute the result based on do_sub
        case (do_sub)
            0: out = a + b;
            1: out = a - b;
        endcase

        // Set result_is_zero if the computed result is zero
        if (out == 8'b0)
            result_is_zero = 1;
        else
            result_is_zero = 0;
    end

endmodule
