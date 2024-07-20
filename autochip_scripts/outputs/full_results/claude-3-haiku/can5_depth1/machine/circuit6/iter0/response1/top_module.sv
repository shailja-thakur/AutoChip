module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case (a)
        3'b000: q = 16'h1232;
        3'b001: q = 16'hb040;
        3'b010: q = 16'h2824;
        3'b011: q = 16'h5a4e;
        3'b100: q = 16'h206c;
        3'b101: q = 16'h6446;
        3'b110: q = 16'hc4e6;
        3'b111: q = 16'h2f19;
    endcase
end

endmodule
