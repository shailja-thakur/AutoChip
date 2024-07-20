module top_module (
   input clk,
   input reset,
   input x,
   output reg z
);
   reg [2:0] state;    // Internal state variable
   
   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 3'b000;    // Initialize state to A
      else begin
         case(state)
            3'b000: if (x) state <= 3'b001; else state <= 3'b000;    // If state is A and x is high, next state is B. If x is low, next state is A.
            3'b001: if (x) state <= 3'b100; else state <= 3'b001;    // If state is B and x is high, next state is E. If x is low, next state is B.
            3'b010: if (x) state <= 3'b001; else state <= 3'b010;    // If state is C and x is high, next state is B. If x is low, next state is C.
            3'b011: if (x) state <= 3'b010; else state <= 3'b011;    // If state is D and x is high, next state is C. If x is low, next state is D.
            3'b100: if (x) state <= 3'b011; else state <= 3'b100;    // If state is E and x is high, next state is E. If x is low, next state is D.
         endcase
      end
   end

   always @(state) begin
      if (state == 3'b100 || state == 3'b101)
         z <= 1'b1;    // Set output high when state is D or E
      else
         z <= 1'b0;    // Set output low for all other states
   end
endmodule
