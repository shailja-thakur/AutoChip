module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @* begin
    case (a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'hAD90;
        3'b010: q = 16'h27BC;
        3'b011: q = 16'h59F6;
        3'b100: q = 16'h206A;
        3'b101: q = 16'h6456;
        3'b110: q = 16'hC54E;
        3'b111: q = 16'h2F79;
    endcase
end

endmodule
