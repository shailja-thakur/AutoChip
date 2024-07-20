module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(do_sub, a, b) begin
    case (do_sub)
        1'b0: // Addition
            begin
                out <= a + b;
                result_is_zero <= (a + b == 8'b0) ? 1'b1 : 1'b0;
            end
        1'b1: // Subtraction
            begin
                out <= a - b;
                result_is_zero <= (a - b == 8'b0) ? 1'b1 : 1'b0;
            end
        default:
            begin
                out <= 8'b0;
                result_is_zero <= 1'b0;
            end
    endcase
end

endmodule
