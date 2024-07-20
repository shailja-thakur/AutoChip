module top_module (
  input [31:0] in,
  output [31:0] out
);
  
  reg [7:0] temp[3:0];
  
  always @(in)
  begin
    temp[0] = in[7:0];
    temp[1] = in[15:8];
    temp[2] = in[23:16];
    temp[3] = in[31:24];
    
    out = {temp[3], temp[2], temp[1], temp[0]};
  end
endmodule
