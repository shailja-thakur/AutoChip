module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

  reg [255:0] mux_out;
  
  always @(*)
  begin
    case(sel)
      8'd0 : mux_out = in[0];
      8'd1 : mux_out = in[1];
      8'd2 : mux_out = in[2];
      8'd3 : mux_out = in[3];
      8'd4 : mux_out = in[4];
      8'd5 : mux_out = in[5];
      8'd6 : mux_out = in[6];
      8'd7 : mux_out = in[7];
      default: mux_out = in[0];
    endcase
  end
  
  assign out = mux_out;

endmodule
