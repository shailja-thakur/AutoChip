module top_module(
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);
  reg ringer;
  reg motor;

  always @(*) begin
    if (vibrate_mode)
      motor = 1;
    else
      ringer = 1;
    end
  endmodule
