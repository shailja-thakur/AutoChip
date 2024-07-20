module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
  reg [98:0] both_temp;
  reg [99:1] any_temp;
  reg [99:0] different_temp;
  
  // Logic for out_both
  always @(in) begin
    both_temp[0] = in[0] & in[99];
    for (int i = 1; i < 99; i = i+1) begin
      both_temp[i] = in[i] & in[i-1];
    end
  end
  
  // Logic for out_any
  always @(in) begin
    any_temp[99] = in[99];
    for (int j = 0; j < 99; j = j+1) begin
      any_temp[j] = in[j] | in[j+1];
    end
  end
  
  // Logic for out_different
  always @(in) begin
    different_temp[99] = in[99] !== in[0];
    for (int k = 0; k < 99; k = k+1) begin
      different_temp[k] = in[k] !== in[k+1];
    end
  end
  
  // Assign outputs
  assign out_both = both_temp;
  assign out_any = any_temp;
  assign out_different = different_temp;
  
endmodule
