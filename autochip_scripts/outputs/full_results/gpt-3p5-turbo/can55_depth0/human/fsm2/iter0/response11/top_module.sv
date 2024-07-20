module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
   reg [1:0] state, next_state;
   parameter OFF = 2'b00, ON = 2'b01;
   
   always @(posedge clk or posedge areset) begin
       if (areset) 
           state <= OFF;
       else
           state <= next_state;
   end
   
   always @* begin
       case (state)
           OFF: begin
               if (j)
                   next_state = ON;
               else
                   next_state = OFF;
           end
           ON: begin
               if (k)
                   next_state = OFF;
               else
                   next_state = ON;
           end
       endcase
   end
   
   always @(state) begin
       case (state)
           OFF: out = 1'b0;
           ON: out = 1'b1;
       endcase
   end
endmodule
