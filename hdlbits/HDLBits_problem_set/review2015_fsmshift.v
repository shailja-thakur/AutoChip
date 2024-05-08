// As part of the FSM for controlling the shift register, we want the ability to enable the shift register for exactly 4 clock cycles whenever the proper bit pattern is detected. Design an FSM handles enabling the shift register for 4 cycles.

// Whenever the FSM is reset, assert shift_ena for 4 cycles, then 0 forever (until reset).

module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    // Insert your code here
    
endmodule
