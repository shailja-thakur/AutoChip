module top_module (
   input clk,
   input j,
   input k,
   input reset,
   output reg out
);

   // State enum declaration
   typedef enum logic [1:0] {OFF, ON} state_type;
   state_type current_state, next_state;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         current_state <= OFF;
      end
      else begin
         current_state <= next_state;
      end
   end

   always @(current_state, j, k) begin
      case (current_state)
         OFF: begin
            if (j) begin
               next_state = ON;
            end
            else begin
               next_state = OFF;
            end
         end
         ON: begin
            if (k) begin
               next_state = OFF;
            end
            else begin
               next_state = ON;
            end
         end
         default: next_state = OFF;
      endcase
   end

   always @(current_state) begin
      case (current_state)
         OFF: begin
            out = 0;
         end
         ON: begin
            out = 1;
         end
         default: out = 0;
      endcase
   end

endmodule
