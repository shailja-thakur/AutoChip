module top_module (
   input clk,
   input resetn,
   input x,
   input y,
   output f,
   output g
);

   reg [1:0] state, next_state;

   always @(posedge clk or negedge resetn)
   begin
      if (~resetn)
         state <= 2'b0;
      else
         state <= next_state;
   end

   // FSM state transition logic
   always @ (*)
   begin
      case (state)
         2'b00:
         begin
            if (~resetn)
               next_state = 2'b1;
            else if (x == 1'b1)
               next_state = 2'b01;
            else
               next_state = 2'b00;
         end

         2'b01:
         begin
            if (x == 1'b0)
               next_state = 2'b10;
            else
               next_state = 2'b01;
         end

         2'b10:
         begin
            if (x == 1'b1)
               next_state = 2'b11;
            else
               next_state = 2'b10;
         end

         2'b11:
         begin
            if (y == 1'b1)
               next_state = 2'b11;
            else
               next_state = 2'b00;
         end

         default:
            next_state = 2'b0;
      endcase
   end

   // FSM output logic
   always @ (*)
   begin
      case (state)
         2'b0:
         begin
            f = 1'b0;
            g = 1'b0;
         end

         2'b1:
         begin
            f = 1'b1;
            g = 1'b0;
         end

         2'b01, 2'b10:
         begin
            f = 1'b0;
            g = 1'b0;
         end

         2'b11:
         begin
            f = 1'b0;
            g = 1'b1;
         end

         default:
            f = 1'b0;
            g = 1'b0;
      endcase
   end
endmodule
