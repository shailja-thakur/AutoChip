module top_module (
    input x3,
    input x2,
    input x1,
    output reg f
);

always @(*) begin
    case ({x3, x2, x1})
        3'b000: f = 0;
        3'b001: f = 0;
        3'b010: f = 1;
        3'b011: f = 1;
        3'b100: f = 0;
        3'b101: f = 1;
        3'b110: f = 0;
        3'b111: f = 1;
        default: f = 0;
    endcase
end

endmodule
