module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @* begin
  case({a, b, c, d, e})
    5'b0000: q = 4'b1111;
    5'b0001: q = b;
    5'b0010: q = e;
    5'b0011: q = d;
    5'b0100: q = b;
    default: q = 4'b1111;
  endcase
end

endmodule
