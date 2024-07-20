module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000, 3'b101, 3'b110: Y2 = w;
            3'b001, 3'b011, 3'b100: Y2 = ~w;
            3'b010: Y2 = 1'b0;
            default: Y2 = 1'bx;
        endcase
    end

endmodule
