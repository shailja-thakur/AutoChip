module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

wire [255:0] mux_out;
assign out = mux_out[sel];

mux_256to1 #(
    .WIDTH(256)
) mux_inst (
    .data(in),
    .sel(sel),
    .out(mux_out)
);

endmodule
module mux_256to1 (
    input [255:0] data,
    input [7:0] sel,
    output reg out
);
// Internal wires and reg
wire [7:0] sel_wire;
wire [7:0] not_sel_wire;
wire [255:0] sel_data;
reg [7:0] i;

// Splitting sel into individual bits
assign sel_wire = sel;
assign not_sel_wire = ~sel;
assign sel_data = {not_sel_wire & data};

always @(*) begin
  out = 0;
  for (i = 0; i < 8; i = i + 1) begin
    if (sel_wire[i]) begin
      out = out | sel_data[i*32 +: 32];
    end
  end
end

endmodule
