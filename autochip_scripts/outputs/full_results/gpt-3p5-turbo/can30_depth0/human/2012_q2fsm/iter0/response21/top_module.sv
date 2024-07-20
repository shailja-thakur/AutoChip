module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
   // State encoding
   parameter A = 2'b00;
   parameter B = 2'b01;
   parameter C = 2'b10;
   parameter D = 2'b11;

   // State register
   reg [1:0] state_reg;
   always @(posedge clk or posedge reset)
   begin
       if (reset)
           state_reg <= A;
       else
           state_reg <= next_state;
   end
   
   // Next state logic
   reg [1:0] next_state;
   always @*
   begin
       case(state_reg)
           A: if (w) next_state = B; else next_state = A;
           B: if (w) next_state = C; else next_state = D;
           C: if (w) next_state = E; else next_state = D;
           D: if (w) next_state = F; else next_state = A;
           E: if (z) next_state = E; else next_state = D;
           F: if (z) next_state = C; else next_state = D;
           default: next_state = A;
       endcase
   end
   
   // Output logic
   always @(state_reg)
   begin
       case(state_reg)
           E, F: z = 1;
           default: z = 0;
       endcase
   end
endmodule
