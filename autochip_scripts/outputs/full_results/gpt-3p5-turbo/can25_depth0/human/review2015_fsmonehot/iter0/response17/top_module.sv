module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );
 
  // Define the combinational logic for state transition and output logic
  // Derive the next-state logic equations and output logic equations by inspection
  
  // Define the next-state logic
  
  assign B3_next = state[2] & shift_ena;   // B3_next = B3 & shift_ena
  
  assign S_next = (state[0] & ~d) | (state[1] & d);   // S_next = S & ~d | S1 & d
  
  assign S1_next = (state[0] & ~d) | (state[1] & d & ~d);   // S1_next = S & ~d | S1 & d & ~d
  
  assign Count_next = (state[4] & counting & ~done_counting) | (state[4] & counting & done_counting);   // Count_next = Count & counting & ~done_counting | Count & counting & done_counting
  
  assign Wait_next = (state[8] & done) | (state[8] & ~done);   // Wait_next = Wait & done | Wait & ~done
  
  // Define the output logic
  
  assign done = state[9];   // done = Wait
  
  assign counting = state[7];   // counting = Count
 
  assign shift_ena = state[5] | state[6] | state[7];   // shift_ena = B0 | B1 | B2
endmodule
