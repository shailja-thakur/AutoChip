module top_module (
	input [31:0] in,
	output [31:0] out
);
  reg [7:0] out_chunk[3:0];

  always @(in) begin
    out_chunk[0] = in[7:0];
    out_chunk[1] = in[15:8];
    out_chunk[2] = in[23:16];
    out_chunk[3] = in[31:24];
    out = {out_chunk[3], out_chunk[2], out_chunk[1], out_chunk[0]};
  end
  
endmodule
