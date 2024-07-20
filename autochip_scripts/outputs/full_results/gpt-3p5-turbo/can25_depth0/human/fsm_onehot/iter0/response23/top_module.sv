module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
  
  // State transition logic
  always @ (*) begin
    case(state)
      // State S0
      10'b0000000001:
        if (in == 1'b1)
          next_state = 10'b0000000010; // Transition to S1
        else
          next_state = 10'b0000000001; // Remain in S0
      // State S1
      10'b0000000010:
        if (in == 1'b1)
          next_state = 10'b0000000100; // Transition to S2
        else
          next_state = 10'b0000000001; // Transition to S0
      // State S2
      10'b0000000100:
        if (in == 1'b1)
          next_state = 10'b0000001000; // Transition to S3
        else
          next_state = 10'b0000000001; // Transition to S0
      // State S3
      10'b0000001000:
        if (in == 1'b1)
          next_state = 10'b0000010000; // Transition to S4
        else
          next_state = 10'b0000000001; // Transition to S0
      // State S4
      10'b0000010000:
        if (in == 1'b1)
          next_state = 10'b0000100000; // Transition to S5
        else
          next_state = 10'b0000000001; // Transition to S0
      // State S5
      10'b0000100000:
        if (in == 1'b1)
          next_state = 10'b0010000000; // Transition to S8
        else
          next_state = 10'b0000000010; // Transition to S6
      // State S6
      10'b0000000010:
        if (in == 1'b1)
          next_state = 10'b0100000000; // Transition to S9
        else
          next_state = 10'b0000000100; // Transition to S7
      // State S7
      10'b0000000100:
        if (in == 1'b1)
          next_state = 10'b0000000001; // Transition to S0
        else
          next_state = 10'b0000000100; // Remain in S7
      // State S8
      10'b0010000000:
        if (in == 1'b1)
          next_state = 10'b0000000010; // Transition to S1
        else
          next_state = 10'b0000000001; // Transition to S0
      // State S9
      10'b0100000000:
        if (in == 1'b1)
          next_state = 10'b0000000010; // Transition to S1
        else
          next_state = 10'b0000000001; // Transition to S0
    endcase
  end
  
  // Output logic
  assign out2 = (state == 10'b0000000111 || state == 10'b0010000001);
  assign out1 = (state == 10'b0010000000);
  
endmodule
