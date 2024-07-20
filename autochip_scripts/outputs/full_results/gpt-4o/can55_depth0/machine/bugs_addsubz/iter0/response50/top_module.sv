module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(*) begin
    case (do_sub)
        1'b0: out = a + b;  // perform addition
        1'b1: out = a - b;  // perform subtraction
        default: out = 8'b0;  // default case
    endcase

    // Check if the result is zero
    if (out == 8'd0) 
        result_is_zero = 1'b1;
    else 
        result_is_zero = 1'b0;
end

endmodule
