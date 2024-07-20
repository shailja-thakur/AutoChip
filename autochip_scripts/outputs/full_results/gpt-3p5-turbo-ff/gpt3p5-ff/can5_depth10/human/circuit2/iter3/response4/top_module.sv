module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

always @* begin
    case ({a, b, c, d})
        4'b0000: q = 1;
        4'b0001: q = 1;
        4'b0010: q = 1;
        4'b0101: q = 1;
        4'b0110: q = 1;
        4'b1001: q = 1;
        4'b1010: q = 1;
        4'b1100: q = 1;
        4'b1111: q = 1;
        4'b0011,
        4'b0100,
        4'b0111,
        4'b1000,
        4'b1011,
        4'b1101,
        4'b1110: q = 0;
    endcase
end

endmodule
