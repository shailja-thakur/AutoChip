module top_module (
  input [255:0] in,
  input [7:0] sel,
  output out
);

  reg [7:0] sel_expanded;

  always @(*) begin
    case (sel)
      0: sel_expanded = 8'b00000001;
      1: sel_expanded = 8'b00000010;
      2: sel_expanded = 8'b00000100;
      3: sel_expanded = 8'b00001000;
      4: sel_expanded = 8'b00010000;
      5: sel_expanded = 8'b00100000;
      6: sel_expanded = 8'b01000000;
      7: sel_expanded = 8'b10000000;
      default: sel_expanded = 8'b00000000;
    endcase
  end

  assign out = in & sel_expanded;

endmodule
