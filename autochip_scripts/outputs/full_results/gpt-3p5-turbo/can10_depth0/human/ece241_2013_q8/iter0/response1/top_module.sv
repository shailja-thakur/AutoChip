module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

   reg [1:0] state;
   reg [2:0] next_state;
   
   parameter S0 = 2'b00;
   parameter S1 = 2'b01;
   parameter S2 = 2'b10;
   parameter S3 = 2'b11;
   
   always @(posedge clk or negedge aresetn)
   if (~aresetn)
       state <= S0;
   else
       state <= next_state;
   
   always @(state or x)
       case(state)
           S0: if (x) next_state <= S1; else next_state <= S0;
           S1: if (x) next_state <= S2; else next_state <= S0;
           S2: if (x) next_state <= S3; else next_state <= S0;
           S3: if (x) next_state <= S2; else next_state <= S0;
           default: next_state <= S0;
       endcase
   
   always @(state)
       case(state)
           S0: z <= 0;
           S1: z <= 0;
           S2: z <= 1;
           S3: z <= 0;
           default: z <= 0;
       endcase
   
endmodule
