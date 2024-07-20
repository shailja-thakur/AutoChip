module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] mux_sel;

always @*
begin
  case(sel)
    8'b00000000: mux_sel = in[0];
    8'b00000001: mux_sel = in[1];
    8'b00000010: mux_sel = in[2];
    8'b00000011: mux_sel = in[3];
    // continue for the remaining cases
  endcase
  
  out = mux_sel;
  
end

endmodule
