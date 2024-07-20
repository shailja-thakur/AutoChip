module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  reg [98:0] tmp_out_both;
  reg [99:1] tmp_out_any;
  reg [99:0] tmp_out_different;
  
  always @* begin
    // Calculate out_both
    for (int i = 0; i < 99; i = i + 1) begin
      tmp_out_both[i] = (in[i] & in[i+1]);
    end
    
    // Calculate out_any
    for (int i = 1; i < 99; i = i + 1) begin
      tmp_out_any[i] = (in[i] | in[i-1]);
    end
    
    // Calculate out_different
    for (int i = 0; i < 99; i = i + 1) begin
      tmp_out_different[i] = (in[i] != in[i+1]);
    end
    tmp_out_different[99] = (in[99] != in[0]);
      
  end
  
  assign out_both = tmp_out_both;
  assign out_any = tmp_out_any;
  assign out_different = tmp_out_different;

endmodule
