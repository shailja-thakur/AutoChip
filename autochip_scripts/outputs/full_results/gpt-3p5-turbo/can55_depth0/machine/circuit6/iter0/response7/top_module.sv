module top_module (
    input [2:0] a, 
    output reg [15:0] q
);

always @* begin
    case(a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'hAF80;
        3'b010: q = 16'h27BC;
        3'b011: q = 16'h59AE;
        3'b100: q = 16'h206A;
        3'b101: q = 16'h6446;
        3'b110: q = 16'hC536;
        3'b111: q = 16'h2F19;
        default: q = 16'h0;
    endcase
end

endmodule
