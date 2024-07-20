module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case (a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'haff0;
        3'b010: q = 16'h2804;
        3'b011: q = 16'h5a2e;
        3'b100: q = 16'h206e;
        3'b101: q = 16'h64ce;
        3'b110: q = 16'hc4e6;
        3'b111: q = 16'hd109;
        default: q = 16'h0000;
    endcase
end

endmodule
