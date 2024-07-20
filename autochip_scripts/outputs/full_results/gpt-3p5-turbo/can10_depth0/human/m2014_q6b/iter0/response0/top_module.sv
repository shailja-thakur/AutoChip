module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case(y)
        3'd1: Y2 = w & 1;
        3'd2: Y2 = w & 1;
        3'd3: Y2 = w & 1;
        3'd4: Y2 = w & 1;
        3'd5: Y2 = w & 1;
        3'd6: Y2 = w & 1;
        default: Y2 = 0;
    endcase
end

endmodule
