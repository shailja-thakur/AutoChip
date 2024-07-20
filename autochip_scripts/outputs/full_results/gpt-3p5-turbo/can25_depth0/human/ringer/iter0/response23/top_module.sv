module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign the ringer output based on the input conditions
    assign ringer = (vibrate_mode == 1) ? 0 : ring;
  
    // Assign the motor output based on the input conditions
    assign motor = (vibrate_mode == 1) ? 1 : ring;

endmodule
