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
        endcase
        
        // The issue with the original code was that the condition `~out` would only be true if the output is exactly 0,
        // which is not the correct condition for checking if the result is zero. 
        // The correct way to check for zero is to compare the output value directly.
        result_is_zero = (out == 8'b0);
    end

endmodule
