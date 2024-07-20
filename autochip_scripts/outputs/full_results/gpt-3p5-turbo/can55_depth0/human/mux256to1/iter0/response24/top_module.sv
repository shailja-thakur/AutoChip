module top_module (
  input [255:0] in,
  input [7:0] sel,
  output  out
);

  reg [7:0] sel_extended;
  wire [255:0] in_extended;
  wire [7:0] mux_sel;
  
  assign in_extended = {256{sel_extended}};
  assign mux_sel = sel_extended[7:0];
  
  always @ (sel) begin
    case (sel)
      0: sel_extended = 8'b00000001;
      1: sel_extended = 8'b00000010;
      2: sel_extended = 8'b00000100;
      3: sel_extended = 8'b00001000;
      4: sel_extended = 8'b00010000;
      5: sel_extended = 8'b00100000;
      6: sel_extended = 8'b01000000;
      7: sel_extended = 8'b10000000;
      default: sel_extended = 8'b00000000;
    endcase
  end
  
  mux_8to1 mux (
    .in(in_extended),
    .sel(mux_sel),
    .out(out)
  );

endmodule
module mux_8to1 (
  input [255:0] in,
  input [7:0] sel,
  output out
);
  
  assign out = in[sel];

endmodule
