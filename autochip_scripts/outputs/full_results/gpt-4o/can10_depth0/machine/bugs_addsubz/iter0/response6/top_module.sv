module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(*) begin
    case(do_sub)
        1'b0: out = a + b;  // Perform addition
        1'b1: out = a - b;  // Perform subtraction
        default: out = a + b; // Default to addition for safety
    endcase
    
    result_is_zero = (out == 8'b00000000) ? 1'b1 : 1'b0; // Check if result is zero
end

endmodule
