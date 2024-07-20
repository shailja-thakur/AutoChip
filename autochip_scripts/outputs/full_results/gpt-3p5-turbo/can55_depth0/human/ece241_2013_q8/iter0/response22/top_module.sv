module top_module (
   input clk,
   input aresetn,
   input x,
   output reg z
);

   reg [1:0] state, next_state;

   always @(posedge clk or negedge aresetn) begin
      if (!aresetn)
         state <= 2'b00;
      else
         state <= next_state;
   end

   always @(state or x) begin
      z = 0;
      next_state = state;

      case (state)
         0: if (x == 1'b1)
               next_state = 1;
         1: if (x == 1'b0)
               next_state = 2;
         2: if (x == 1'b1)
               begin
                  next_state = 1;
                  z = 1;
               end
      endcase
   end

endmodule
