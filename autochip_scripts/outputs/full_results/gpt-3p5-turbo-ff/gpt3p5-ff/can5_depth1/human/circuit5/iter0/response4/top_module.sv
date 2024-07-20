module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @* begin
    case ({a, b, c, d, e})
        5'b0_1011: q = b;
        5'b1_0000: q = e;
        5'b1_0010: q = a;
        5'b1_0100: q = d;
        default: q = f;
    endcase
end

endmodule
