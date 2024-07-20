module top_module (
    input [2:0] a, 
    output reg [15:0] q
);

always @(*) begin
    case (a)
        3'b000: q <= 16'h1232;
        3'b001: q <= 16'hab20;
        3'b010: q <= 16'h2804;
        3'b011: q <= 16'h5a4e;
        3'b100: q <= 16'h2066;
        3'b101: q <= 16'h6472;
        3'b110: q <= 16'hc466;
        3'b111: q <= 16'h2f99;
    endcase
end

endmodule
