module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        // Perform addition or subtraction based on the do_sub signal
        if (do_sub)
            out = a - b;
        else
            out = a + b;

        // Set result_is_zero to 1 if the result is zero; otherwise, set it to 0
        if (out == 0)
            result_is_zero = 1;
        else
            result_is_zero = 0;
    end

endmodule
