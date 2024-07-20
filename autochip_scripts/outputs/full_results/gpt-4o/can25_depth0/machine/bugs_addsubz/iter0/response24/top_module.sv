module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);
    always @(do_sub or a or b) begin
        case (do_sub)
            1'b0: out = a + b; // Perform addition
            1'b1: out = a - b; // Perform subtraction
            default: out = 8'b0; // Default case to avoid latches
        endcase
        result_is_zero = (out == 8'b0) ? 1 : 0; // Check if result is zero
    end
endmodule
