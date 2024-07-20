module top_module (
   input clk,
   input reset,
   input x,
   output reg z
);
   
   // State variables
   reg [2:0] curr_state;
   reg [2:0] next_state;
   
   // State assignment table
   parameter [2:0] STATE_000 = 3'b000;
   parameter [2:0] STATE_001 = 3'b001;
   parameter [2:0] STATE_010 = 3'b010;
   parameter [2:0] STATE_011 = 3'b011;
   parameter [2:0] STATE_100 = 3'b100;
   
   // Default initial state
   initial begin
      curr_state = STATE_000;
      next_state = STATE_000;
   end
   
   // State transition logic
   always @(posedge clk or posedge reset) begin
      if (reset)
         curr_state <= STATE_000;
      else
         curr_state <= next_state;
   end
   
   // Output logic
   always @(curr_state, x) begin
      case(curr_state)
         STATE_000: begin
            if (x)
               next_state = STATE_001;
            else
               next_state = STATE_000;
            z = 0;
         end
         STATE_001: begin
            if (x)
               next_state = STATE_100;
            else
               next_state = STATE_001;
            z = 0;
         end
         STATE_010: begin
            if (x)
               next_state = STATE_001;
            else
               next_state = STATE_010;
            z = 0;
         end
         STATE_011: begin
            if (x)
               next_state = STATE_010;
            else
               next_state = STATE_001;
            z = 1;
         end
         STATE_100: begin
            if (x)
               next_state = STATE_100;
            else
               next_state = STATE_011;
            z = 1;
         end
      endcase
   end
endmodule
