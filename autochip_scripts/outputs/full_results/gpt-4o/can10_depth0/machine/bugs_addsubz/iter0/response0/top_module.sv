module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(do_sub or a or b) begin
        case (do_sub)
            1'b0: out = a + b;  // Perform addition
            1'b1: out = a - b;  // Perform subtraction
            default: out = 8'b0; // Default case to handle unexpected values
        endcase

        // Set result_is_zero to 1 if the result is 0, otherwise 0
        result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0;
    end

endmodule
