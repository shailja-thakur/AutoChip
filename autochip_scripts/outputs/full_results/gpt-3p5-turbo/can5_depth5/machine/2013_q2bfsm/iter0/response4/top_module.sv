module top_module (
   input clk,
   input resetn,
   input x,
   input y,
   output f,
   output g
);

   reg [3:0] state, next_state;

   always @(posedge clk or negedge resetn) begin
      if (!resetn)
         state <= 4'b0; // Initialize state to S0
      else
         state <= next_state; // Assign next_state to state

      case (state)
         4'b0000: if (x) next_state = 4'b1000; // S0 to S1
                  else   next_state = 4'b0000; // S0 stays in S0
         4'b0001: if (x) next_state = 4'b1000; // S1 stays in S1
                  else   next_state = 4'b1010; // S1 to S10
         4'b0010: if (x) next_state = 4'b0111; // S10 to G1
                  else   next_state = 4'b0000; // S10 to S0
         4'b0100: next_state = 4'b0101; // A to B
         4'b0101: next_state = 4'b0000; // B to S0
         4'b0110: if (y) next_state = 4'b1011; // G1 to P1
                  else   next_state = 4'b1100; // G1 to G2
         4'b0111: if (y) next_state = 4'b1011; // G2 to P1
                  else   next_state = 4'b0110; // G2 to G1
         4'b1000: next_state = 4'b0100; // P0 stays in P0
         4'b1010: next_state = 4'b0100; // P1 stays in P1
         default: next_state = 4'b0000; // Default to S0
      endcase
   end

   always @(state) begin
      case (state)
         4'b0101: f = 1; // Assign f to 1 when state is B
         default: f = 0; // Assign f to 0 for all other states
      endcase
   end

   always @(state) begin
      case (state)
         4'b0110, 4'b0111, 4'b1010: g = 1; // Assign g to 1 when state is G1, G2, or P1
         default: g = 0; // Assign g to 0 for all other states
      endcase
   end

endmodule
