module top_module (
	input clk,
	input in,
	input areset,
	output out
);
   reg [1:0] state, next_state;
   
   parameter B = 2'b00;
   parameter A = 2'b01;
   
   always @(posedge clk or posedge areset)
      if(areset)
         state <= B; 
      else
         state <= next_state;
   
   always @(state, in)
      case(state)
         B: begin
            if(in) 
               next_state <= B;
            else 
               next_state <= A;
            out <= 1'b1;
         end
         A: begin
            if(in) 
               next_state <= A;
            else 
               next_state <= B;
            out <= 1'b0;
         end
      endcase
endmodule
