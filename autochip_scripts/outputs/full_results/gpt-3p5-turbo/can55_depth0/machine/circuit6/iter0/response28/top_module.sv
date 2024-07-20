module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @*
begin
    case (a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'haf80;
        3'b010: q = 16'h287c;
        3'b011: q = 16'h59b5;
        3'b100: q = 16'h207a;
        3'b101: q = 16'h643e;
        3'b110: q = 16'hc51e;
        3'b111: q = 16'h2ef9;
    endcase
end

endmodule
