module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        case (do_sub)
            1'b0: out = a + b;  // Perform addition
            1'b1: out = a - b;  // Perform subtraction
        endcase

        // Check if the result is zero
        if (out == 8'b0) begin
            result_is_zero = 1'b1;
        end else begin
            result_is_zero = 1'b0;
        end
    end

endmodule
