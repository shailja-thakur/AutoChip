module top_module (
	input [99:0] in,
	output [98:0] out_both,
  output [99:0] out_any,
  output [99:0] out_different
);
  reg [98:0] temp_out_both;
  
  // Calculate out_both
  always @* begin
    temp_out_both[0] = (in[0] & in[99]);
    for (int i = 1; i < 99; i++) begin
      temp_out_both[i] = (in[i] & in[i-1]);
    end
  end
  
  // Assign out_both
  assign out_both = temp_out_both;
  
  // Calculate out_any
  always @* begin
    out_any[0] = (in[0] | in[1]);
    for (int i = 1; i < 99; i++) begin
      out_any[i] = (in[i] | in[i+1]);
    end
    out_any[99] = in[99];
  end
  
  // Calculate out_different
  always @* begin
    for (int i = 0; i < 99; i++) begin
      out_different[i] = (in[i] != in[i+1]);
    end
    out_different[99] = (in[99] != in[0]);
  end

endmodule
