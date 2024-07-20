module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(*) begin
    case (do_sub)
        1'b0: out = a + b; // Perform addition
        1'b1: out = a - b; // Perform subtraction
        default: out = 8'h00; // Default case (should not happen)
    endcase

    // Set result_is_zero if the result of the operation is 0
    if (out == 8'h00) begin
        result_is_zero = 1'b1;
    end else begin
        result_is_zero = 1'b0;
    end
end

endmodule
