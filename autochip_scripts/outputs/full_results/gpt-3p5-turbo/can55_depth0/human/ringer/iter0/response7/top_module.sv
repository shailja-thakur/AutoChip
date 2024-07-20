module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);
    
    // Instantiate the ringer and motor
    ringer_module ringer_inst(
        .ring(ring),
        .vibrate_mode(vibrate_mode),
        .ringer(ringer)
    );
    
    motor_module motor_inst(
        .vibrate_mode(vibrate_mode),
        .motor(motor)
    );
    
endmodule
module ringer_module(
    input ring,
    input vibrate_mode,
    output ringer
);
    
    assign ringer = (vibrate_mode == 1) ? 0 : ring;
    
endmodule
module motor_module(
    input vibrate_mode,
    output motor
);
    
    assign motor = (vibrate_mode == 1) ? 1 : 0;
    
endmodule
