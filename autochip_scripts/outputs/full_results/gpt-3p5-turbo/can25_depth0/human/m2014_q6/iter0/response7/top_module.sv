module top_module (
   input clk,
   input reset,
   input w,
   output reg z
);

   // define states
   parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

   // define current state and next state variables
   reg [2:0] state, next_state;

   // combinational logic for next state calculation
   always @(*) begin
      case (state)
         A: if (w == 1) next_state = A; else next_state = B;
         B: if (w == 1) next_state = D; else next_state = C;
         C: if (w == 1) next_state = D; else next_state = E;
         D: if (w == 1) next_state = A; else next_state = F;
         E: if (state == 1) next_state = D; else next_state = E;
         F: if (state == 1) next_state = D; else next_state = C;
      endcase
   end

   // sequential logic for state transition and output generation
   always @(posedge clk or posedge reset) begin
      if (reset) state <= A;
      else state <= next_state;

      case (state)
         A: z <= 0;
         E: z <= 1;
         default: z <= 0;
      endcase
   end

endmodule
