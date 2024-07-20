module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case({a, b, c, d, e})
        {4'b0000, 4'bxxxx}: q = b;
        5'b10_000: q = e;
        5'b10_001: q = a;
        5'b10_010: q = d;
        5'b10_011: q = f;
        default: q = f;
    endcase
end

endmodule
