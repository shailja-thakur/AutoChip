module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);
    always @(*) begin
        case (do_sub)
            0: begin
                out = a + b;
                result_is_zero = (out == 8'b00000000);
            end
            1: begin
                out = a - b;
                result_is_zero = (out == 8'b00000000);
            end
            default: begin
                out = 8'b00000000;
                result_is_zero = 1'b0;
            end
        endcase
    end
endmodule
