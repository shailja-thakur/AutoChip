module top_module (
  input clk,
  input in,
  input reset,
  output out
);

   // Define states
   typedef enum logic [1:0] {A, B, C, D} stateType;
   // Define current state
   stateType currentState, nextState;
   
   // Assign initial state
   always_ff @(posedge clk or posedge reset) begin
      if (reset)
         currentState <= A;
      else
         currentState <= nextState;
   end
   
   // Assign next state and output based on current state and inputs
   always_comb begin
      case (currentState)
         A: begin
            if (in)
               nextState = B;
            else
               nextState = A;
               
            out = 0;
         end
         
         B: begin
            if (in)
               nextState = B;
            else
               nextState = C;
               
            out = 0;
         end
         
         C: begin
            if (in)
               nextState = D;
            else
               nextState = A;
               
            out = 0;
         end
         
         D: begin
            if (in)
               nextState = B;
            else
               nextState = C;
               
            out = 1;
         end
         
         default: begin
            nextState = A;
            out = 0;
         end
      endcase
   end
endmodule
