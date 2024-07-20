module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(*) begin
    case (do_sub)
        1'b0: out = a + b;  // Perform addition if do_sub is 0
        1'b1: out = a - b;  // Perform subtraction if do_sub is 1
        default: out = 8'b0; // Default case, though it should never be hit since do_sub is a single bit
    endcase
    result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0; // Set result_is_zero to 1 if out is 0, otherwise 0
end

endmodule
