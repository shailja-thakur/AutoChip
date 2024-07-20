module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(a, b, c, d, e) begin
    case ({a, b, c, d, e})
        5'b01110: q = 4'b1011;
        5'b10010: q = 4'b1110;
        5'b10100: q = 4'b0001;
        5'b11010: q = 4'b1101;
        5'b11101: q = 4'b1111;
        default: q = 4'b0000;
    endcase
end

endmodule
