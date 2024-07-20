module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        // Perform addition or subtraction based on the 'do_sub' signal
        if (do_sub) 
            out = a - b;
        else 
            out = a + b;

        // Check if the result is zero
        if (out == 8'd0)
            result_is_zero = 1;
        else
            result_is_zero = 0;
    end

endmodule
