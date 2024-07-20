module top_module (
  input [3:0] in,
  output reg [1:0] pos
);

always @(*) begin
  if (in[0])
    pos = 0;
  else if (in[1])
    pos = 1;
  else if (in[2])
    pos = 2;
  else if (in[3])
    pos = 3;
  else
    pos = 0;
end

endmodule
