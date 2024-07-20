module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire [3:0] inputs;
assign inputs = {a, b, c, d};

always @(*) begin
    case (inputs)
        4'b0000: q = 1'b1;
        4'b0001: q = 1'b0;
        4'b0010: q = 1'b0;
        4'b0011: q = 1'b1;
        4'b0100: q = 1'b0;
        4'b0101: q = 1'b1;
        4'b0110: q = 1'b1;
        4'b0111: q = 1'b0;
        4'b1000: q = 1'b0;
        4'b1001: q = 1'b1;
        4'b1010: q = 1'b1;
        4'b1011: q = 1'b0;
        4'b1100: q = 1'b1;
        4'b1101: q = 1'b0;
        4'b1110: q = 1'b0;
        4'b1111: q = 1'b1;
        default: q = 1'bx;
    endcase
end

endmodule
