module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @* begin
  case({a, b})
    2'b00 : q = 4'b1111;
    2'b01 : q = b;
    2'b10 : q = e;
    2'b11 : q = 4'b1010;
    default: q = 4'b1111;
  endcase
end

endmodule
