module top_module(
  input ring, 
  input vibrate_mode,
  output ringer,
  output motor
);
  reg ringer_out, motor_out;
  always @(ring or vibrate_mode) begin
    if (vibrate_mode) begin
      ringer_out <= 0;
      motor_out <= 1;
    end else begin
      ringer_out <= 1;
      motor_out <= 0;
    end
  end
  
  assign ringer = ringer_out;
  assign motor = motor_out;
endmodule
