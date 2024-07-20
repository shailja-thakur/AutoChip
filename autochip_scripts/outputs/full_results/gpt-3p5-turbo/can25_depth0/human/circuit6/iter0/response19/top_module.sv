module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @* begin
    case(a)
        3'b000: q = 16'h1232; // q = 1232 in hexadecimal
        3'b001: q = 16'haee0; // q = aee0 in hexadecimal
        3'b010: q = 16'h27d4; // q = 27d4 in hexadecimal
        3'b011: q = 16'h5a0e; // q = 5a0e in hexadecimal
        3'b100: q = 16'h2066; // q = 2066 in hexadecimal
        3'b101: q = 16'h64ce; // q = 64ce in hexadecimal
        3'b110: q = 16'hc526; // q = c526 in hexadecimal
        3'b111: q = 16'h2f19; // q = 2f19 in hexadecimal
        default: q = 16'h0000; // default case
    endcase
end

endmodule
