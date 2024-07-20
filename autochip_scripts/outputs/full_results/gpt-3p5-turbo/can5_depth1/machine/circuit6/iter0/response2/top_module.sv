module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @* begin
    case (a)
        3'b000: q = 16'd4658;
        3'b001: q = 16'd44768;
        3'b010: q = 16'd10196;
        3'b011: q = 16'd23054;
        3'b100: q = 16'd8294;
        3'b101: q = 16'd25806;
        3'b110: q = 16'd50470;
        3'b111: q = 16'd12057;
    endcase
end

endmodule
