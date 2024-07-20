module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case (a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'hab40;
        3'b010: q = 16'h2804;
        3'b011: q = 16'h5ace;
        3'b100: q = 16'h206a;
        3'b101: q = 16'h6450;
        3'b110: q = 16'hc4a6;
        3'b111: q = 16'h2f59;
        default: q = 16'h0;
    endcase
end

endmodule
