module top_module (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case (a)
        3'b000: q = 16'h123A;
        3'b001: q = 16'hAEE0;
        3'b010: q = 16'h27EC;
        3'b011: q = 16'h59E6;
        3'b100: q = 16'h205A;
        3'b101: q = 16'h643E;
        3'b110: q = 16'hC536;
        3'b111: q = 16'h2F99;
    endcase
end

endmodule
