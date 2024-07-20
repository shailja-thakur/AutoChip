module top_module (
  input [31:0] in,
  output reg [31:0] out
);

  reg [7:0] temp [0:3];

  always @(in)
  begin
    temp[0] <= in[7:0];
    temp[1] <= in[15:8];
    temp[2] <= in[23:16];
    temp[3] <= in[31:24];
  end

  always @(temp)
  begin
    out <= {temp[3], temp[2], temp[1], temp[0]};
  end
endmodule
