module top_module (
   input in,
   input [9:0] state,
   output [9:0] next_state,
   output out1,
   output out2);

   // Assignments for next_state output
   always @*
   begin
      case (state)
         // Case for S0
         10'b0000000001: next_state = 10'b0000000001; // S0 -> S0
         10'b0000000001: next_state = 10'b0000000010; // S0 -> S1
         // Case for S1
         10'b0000000010: next_state = 10'b0000000001; // S1 -> S0
         10'b0000000010: next_state = 10'b0000000011; // S1 -> S2
         // Case for S2
         10'b0000000011: next_state = 10'b0000000001; // S2 -> S0
         10'b0000000011: next_state = 10'b0000000100; // S2 -> S3
         // Case for S3
         10'b0000000100: next_state = 10'b0000000001; // S3 -> S0
         10'b0000000100: next_state = 10'b0000000101; // S3 -> S4
         // Case for S4
         10'b0000000101: next_state = 10'b0000000001; // S4 -> S0
         10'b0000000101: next_state = 10'b0000000110; // S4 -> S5
         // Case for S5
         10'b0000000110: next_state = 10'b0000001000; // S5 -> S8
         10'b0000000110: next_state = 10'b0000000111; // S5 -> S6
         // Case for S6
         10'b0000000111: next_state = 10'b0000001001; // S6 -> S9
         10'b0000000111: next_state = 10'b0000001000; // S6 -> S7
         // Case for S7
         10'b0000001000: next_state = 10'b0000000001; // S7 -> S0
         10'b0000001000: next_state = 10'b0000001000; // S7 -> S7
         // Case for S8
         10'b0000001001: next_state = 10'b0000000001; // S8 -> S0
         10'b0000001001: next_state = 10'b0000000010; // S8 -> S1
         // Case for S9
         10'b0000001010: next_state = 10'b0000000001; // S9 -> S0
         10'b0000001010: next_state = 10'b0000000010; // S9 -> S1
         default: next_state = 10'b0000000000; // Default case
      endcase
   end

   // Assignments for out1 and out2 outputs
   always @*
   begin
      case (state)
         // Case for S7
         10'b0000001000: begin 
             out1 = 1'b0; 
             out2 = 1'b1; 
         end
         // Case for S9
         10'b0000001001: begin 
             out1 = 1'b1; 
             out2 = 1'b1; 
         end
         default: begin 
             out1 = 1'b0; 
             out2 = 1'b0; 
         end // Default case
      endcase
   end

endmodule
