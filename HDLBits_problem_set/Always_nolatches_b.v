// Suppose you're building a circuit to process scancodes from a PS/2 keyboard for a game. 
// Given the last two bytes of scancodes received, you need to indicate whether one of the 
// arrow keys on the keyboard have been pressed. This involves a fairly simple mapping, 
// which can be implemented as a case statement (or if-elseif) with four cases.


// Scancode [15:0]	Arrow key
// 16'he06b		left arrow
// 16'he072		down arrow
// 16'he074		right arrow
// 16'he075		up arrow
// Anything else	none

// Hint: Your circuit has one 16-bit input, and four outputs. Build this circuit that 
// recognizes these four scancodes and asserts the correct output.

// To avoid creating latches, all outputs must be assigned a value in all possible conditions. 
// Simply having a default case is not enough. You must assign a value to all four outputs in 
// all four cases and the default case. This can involve a lot of unnecessary typing. 
// One easy way around this is to assign a "default value" to the outputs before the case statement:

// always @(*) begin
//    up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b0;
//    case (scancode)
//        ... // Set to 1 as necessary.
//    endcase
// end

// synthesis verilog_input_version verilog_2001
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 

    // Insert your code here

endmodule
