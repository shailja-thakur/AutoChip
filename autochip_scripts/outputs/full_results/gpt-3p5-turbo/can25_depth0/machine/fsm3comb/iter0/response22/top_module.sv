module top_module (
   input in,
   input [1:0] state,
   output reg [1:0] next_state,
   output reg out
);

   always_comb begin
      case(state)
         2'b00: // State A
            if(in)
               next_state = 2'b01; // Next state B
            else
               next_state = 2'b00; // Next state A
               
         2'b01: // State B
            if(in)
               next_state = 2'b01; // Next state B
            else
               next_state = 2'b10; // Next state C
               
         2'b10: // State C
            if(in)
               next_state = 2'b11; // Next state D
            else
               next_state = 2'b00; // Next state A
               
         2'b11: // State D
            if(in)
               next_state = 2'b01; // Next state B
            else
               next_state = 2'b10; // Next state C
      endcase
   end

   assign out = (state == 2'b11); // Output signal indicating state D

endmodule
