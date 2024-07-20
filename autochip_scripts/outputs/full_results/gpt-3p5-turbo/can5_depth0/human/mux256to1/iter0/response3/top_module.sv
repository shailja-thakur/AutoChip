module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] out_wires;

genvar i;
generate
   for (i = 0; i < 256; i = i+1) begin : mux
      assign out_wires[i] = (sel == i) ? in[i] : 1'b0;
   end
endgenerate

assign out = |out_wires;

endmodule
