module top_module (
	input clk,
	input areset,
	input x,
	output z
);

   reg state;
   reg next_state;
   reg z_reg;
   wire x_neg;

   always @(posedge clk or negedge areset)
   begin
       if (areset == 0) begin
           state <= 0;
           next_state <= 0;
           z_reg <= 0;
       end
       else begin
           state <= next_state;
           z_reg <= x_neg;
       end
   end
   
   assign x_neg = ~x + 1;
   
   always @(state, x_neg)
   begin
       case (state)
           0: begin
               if (areset == 0)
                   next_state = 0;
               else if (x_neg == x)
                   next_state = 0;
               else if (x_neg == ~x)
                   next_state = 1;
           end

           1: begin
               if (areset == 0)
                   next_state = 0;
               else if (x_neg == x)
                   next_state = 0;
               else if (x_neg == ~x)
                   next_state = 1;
           end
           
           default:
               next_state = 0;
       endcase
   end
   
   assign z = z_reg;

endmodule
