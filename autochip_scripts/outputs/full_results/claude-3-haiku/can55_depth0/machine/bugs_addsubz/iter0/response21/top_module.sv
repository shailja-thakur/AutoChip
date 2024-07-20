module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(do_sub, a, b) begin
    case (do_sub)
        1'b0: begin
            // Addition
            out = a + b;
            result_is_zero = (out == 8'b0);
        end
        1'b1: begin
            // Subtraction
            out = a - b;
            result_is_zero = (out == 8'b0);
        end
        default: begin
            // Invalid value for do_sub
            out = 8'b0;
            result_is_zero = 1'b0;
        end
    endcase
end

endmodule
