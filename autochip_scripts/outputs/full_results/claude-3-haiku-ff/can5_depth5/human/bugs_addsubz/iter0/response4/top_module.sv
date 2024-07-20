module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        if (do_sub) begin
            out = a - b;
            result_is_zero = (out == 8'b0) ? 1 : 0;
        end
        else begin
            out = a + b;
            result_is_zero = (out == 8'b0) ? 1 : 0;
        end
    end

endmodule
