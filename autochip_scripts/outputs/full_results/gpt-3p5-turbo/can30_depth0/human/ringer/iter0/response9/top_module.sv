module top_module(
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

  // Declare wire to control the ringer and motor
  wire ring_control, motor_control;

  // Process for controlling the ringer and motor
  always @(ring or vibrate_mode) begin
    if (vibrate_mode == 1) begin
      // Vibrate mode is enabled, turn on the motor
      ring_control <= 0;
      motor_control <= 1;
    end else begin
      // Vibrate mode is disabled, turn on the ringer
      ring_control <= 1;
      motor_control <= 0;
    end
  end

  // Assign control signals to the ringer and motor outputs
  assign ringer = ring_control;
  assign motor = motor_control;

endmodule
