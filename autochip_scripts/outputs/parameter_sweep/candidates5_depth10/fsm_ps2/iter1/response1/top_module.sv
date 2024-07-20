module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg done
);

   reg [2:0] state;
   reg [2:0] next_state;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 0;
         done <= 0;
      end else begin
         state <= next_state;
         case (state)
            0: begin
                  if (in[3] == 1)
                     next_state <= 1;
               end
            1: begin
                  if (in[3] == 1)
                     next_state <= 2;
                  else
                     next_state <= 0;
               end
            2: begin
                  if (in[3] == 1) begin
                     next_state <= 1;
                     done <= 1;
                  end else
                     next_state <= 0;
               end
         endcase
      end
   end

endmodule
