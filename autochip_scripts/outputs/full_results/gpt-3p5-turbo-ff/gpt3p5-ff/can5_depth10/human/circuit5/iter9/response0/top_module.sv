module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @* begin
    case({a, b, c, d, e})
        5'b0000: q = a + b;
        5'b0001: q = a - b;
        5'b0010: q = a + c + d;
        5'b0011: q = a - c - d;
        5'b0100: q = a + e;
        default: q = a - e;
    endcase
end

endmodule
