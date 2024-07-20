module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case({a,b,c,d,e})
        16'b00000: q = b;
        16'b00001: q = e;
        16'b00010: q = a;
        16'b00011: q = d;
        16'b00100: q = 4'b1111;
        16'b00101: q = 4'b1111;
        16'b00110: q = 4'b1111;
        16'b00111: q = 4'b1111;
        16'b01000: q = 4'b1111;
        16'b01001: q = 4'b1111;
        16'b01010: q = 4'b1111;
        16'b01011: q = 4'b1111;
        16'b01100: q = 4'b1111;
        16'b01101: q = 4'b1111;
        16'b01110: q = 4'b1111;
        16'b01111: q = 4'b1111;
        16'b10000: q = 4'b1111;
        default: q = 4'b1111;
    endcase
end

endmodule
