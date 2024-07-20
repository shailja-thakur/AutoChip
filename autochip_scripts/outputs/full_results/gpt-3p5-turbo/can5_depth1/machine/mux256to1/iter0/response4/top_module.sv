module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

  reg [7:0] sel_index;
  wire [7:0] out_wire;
  
  assign out = out_wire[0];

  // The selection vector is binary, so we convert it to a decimal sel_index
  always @* begin
    sel_index = 0;
    for (int i=0; i<8; i=i+1) begin
      sel_index = sel_index + (sel[i] << i);
    end
  end

  // Connect the selected bit to the output wire
  assign out_wire = in[sel_index];

endmodule
