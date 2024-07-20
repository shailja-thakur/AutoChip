module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(*) begin
  if (a == 4'b0110) begin
    q = b;
  end else if (a == 4'b0111) begin
    q = e;
  end else if (a == 4'b1000) begin
    q = a;
  end else if (a == 4'b1001) begin
    q = d;
  end else if (a == 4'b1010) begin
    q = f;
  end else begin
    q = 4'b0000;
  end
end

endmodule
