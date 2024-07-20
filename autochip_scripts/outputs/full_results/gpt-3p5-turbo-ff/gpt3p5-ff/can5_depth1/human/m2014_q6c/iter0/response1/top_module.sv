module top_module (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  reg Y2;
  reg Y4;

  always @*
  begin
    Y2 = (y[3] && (w || y[1]));
    Y4 = (y[0] && (w || y[5] || y[2]));
  end

endmodule
