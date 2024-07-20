module top_module (
  input [255:0] in,
  input [7:0] sel,
  output  out
);

  reg [7:0] sel_idx;
  reg out;
  
  always @(*) begin
    case (sel)
      0: sel_idx = 0;
      1: sel_idx = 1;
      2: sel_idx = 2;
      // add cases for sel 3 to 255 here
      default: sel_idx = 0;
    endcase

    out = in[sel_idx];
  end

endmodule
