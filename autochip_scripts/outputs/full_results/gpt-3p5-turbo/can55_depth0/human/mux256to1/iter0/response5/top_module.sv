module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

  reg [7:0] sel_reg;
  wire [7:0] in_sel;
  wire out_wire;

  assign in_sel = in[sel_reg];
  assign out = out_wire;

  always @(sel) begin
    sel_reg <= sel;
  end

  mux256_to_1 mux (
    .in (in_sel),
    .sel (sel_reg),
    .out (out_wire)
  );

endmodule
module mux256_to_1 (
  input [7:0] in,
  input [7:0] sel,
  output out
);

  reg [7:0] out_reg;

  always @(sel or in) begin
    case (sel)
      8'b00000000: out_reg <= in[0];
      8'b00000001: out_reg <= in[1];
      8'b00000010: out_reg <= in[2];
      8'b00000011: out_reg <= in[3];
      // ... continue the pattern for all 256 cases ...
    endcase
  end

  assign out = out_reg;

endmodule
