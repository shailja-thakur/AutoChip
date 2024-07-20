module top_module (
  input [31:0] in,
  output reg [31:0] out
);

  reg [7:0] temp0;
  reg [7:0] temp1;
  reg [7:0] temp2;
  reg [7:0] temp3;
  
  always @(in)
  begin
    temp0 = in[7:0];
    temp1 = in[15:8];
    temp2 = in[23:16];
    temp3 = in[31:24];
  end

  always @(temp0, temp1, temp2, temp3)
  begin
    out = {temp3, temp2, temp1, temp0};
  end
endmodule
