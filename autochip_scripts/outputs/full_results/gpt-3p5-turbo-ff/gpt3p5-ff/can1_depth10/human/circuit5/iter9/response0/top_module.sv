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
            5'b00000: q = a;
            5'b00001: q = b;
            5'b00010: q = c;
            5'b00011: q = d;
            5'b00100: q = e;
            5'b00101: q = a;
            5'b00110: q = b;
            5'b00111: q = c;
            5'b01000: q = d;
            5'b01001: q = e;
            5'b01010: q = a;
            5'b01011: q = b;
            5'b01100: q = c;
            5'b01101: q = d;
            5'b01110: q = e;
            5'b01111: q = a;
            5'b10000: q = b;
            5'b10001: q = c;
            5'b10010: q = d;
            5'b10011: q = e;
            5'b10100: q = a;
            5'b10101: q = b;
            5'b10110: q = c;
            5'b10111: q = d;
            5'b11000: q = e;
            5'b11001: q = a;
            5'b11010: q = b;
            5'b11011: q = c;
            5'b11100: q = d;
            5'b11101: q = e;
            5'b11110: q = a;
            5'b11111: q = b;
            default: q = 4'b0000;
        endcase
    end

endmodule
