module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);
  
  reg [2:0] out_both_temp;
  reg [3:1] out_any_temp;
  reg [3:0] out_different_temp;

  always @* begin
    out_both_temp[0] = in[0] & in[3];
    out_both_temp[1] = in[1] & in[0];
    out_both_temp[2] = in[2] & in[1];
  
    out_any_temp[3] = in[0] | in[1];
    out_any_temp[2] = in[1] | in[2];
    out_any_temp[1] = in[2] | in[3];

    out_different_temp[0] = in[0] != in[3];
    out_different_temp[1] = in[1] != in[0];
    out_different_temp[2] = in[2] != in[1];
    out_different_temp[3] = in[3] != in[2];
  end
  
  assign out_both = out_both_temp;
  assign out_any = out_any_temp;
  assign out_different = out_different_temp;
  
endmodule
