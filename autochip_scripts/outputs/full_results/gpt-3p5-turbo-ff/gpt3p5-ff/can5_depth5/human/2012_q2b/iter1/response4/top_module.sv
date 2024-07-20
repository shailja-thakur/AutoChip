module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

// flop-flop Y1
always @(posedge w) begin
    case(y)
        6'b000001: Y1 <= 1'b0;
        6'b000010: Y1 <= 1'b0;
        6'b000100: Y1 <= 1'b0;
        6'b001000: Y1 <= 1'b1;
        6'b010000: Y1 <= 1'b1;
        6'b100000: Y1 <= 1'b1;
        default: Y1 <= 1'b0;
    endcase
end

// flop-flop Y3
always @(posedge w) begin
    case(y)
        6'b000001: Y3 <= 1'b0;
        6'b000010: Y3 <= 1'b0;
        6'b000100: Y3 <= 1'b1;
        6'b001000: Y3 <= 1'b1;
        6'b010000: Y3 <= 1'b0;
        6'b100000: Y3 <= 1'b0;
        default: Y3 <= 1'b0;
    endcase
end

endmodule
