module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [3:0] hh_tens;
  reg [3:0] hh_ones;
  reg [5:0] mm_tens;
  reg [3:0] mm_ones;
  reg [5:0] ss_tens;
  reg [3:0] ss_ones;

  always @(posedge clk) begin
    if (reset)
      hh_tens <= 4'b0000;
    else if (ena)
      hh_tens <= (hh_tens + 1) % 4'b1010; // increment hh tens counter, reset if overflow

    if (reset || ena)
      hh_ones <= 4'b0000; // reset hh ones counter on reset or enable

    if (reset || ena)
      mm_tens <= 6'b000000; // reset mm tens counter on reset or enable

    if (reset || (ena && (mm_tens == 6'b010101)))
      mm_ones <= (mm_ones + 1) % 4'b1010; // increment mm ones counter, reset if overflow

    if (reset || (ena && (mm_tens == 6'b010101) && (mm_ones == 4'b1001)))
      ss_tens <= (ss_tens + 1) % 6'b011000; // increment ss tens counter, reset if overflow

    if (reset || (ena && (mm_tens == 6'b010101) && (mm_ones == 4'b1001)))
      ss_ones <= (ss_ones + 1) % 4'b1010; // increment ss ones counter, reset if overflow
  end

  always @(posedge clk) begin
    if (reset)
      pm <= 1'b0; // set AM on reset
    else if (ena && (hh_tens == 4'b1010) && (hh_ones == 4'b1001))
      pm <= ~pm; // toggle PM when clock reaches 09:59
  end

  assign hh = {hh_tens, hh_ones};
  assign mm = {mm_tens, mm_ones};
  assign ss = {ss_tens, ss_ones};

endmodule
