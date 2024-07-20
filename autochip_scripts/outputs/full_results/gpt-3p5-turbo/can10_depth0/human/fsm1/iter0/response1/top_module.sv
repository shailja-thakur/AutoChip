module top_module (
   input clk,   // clock input
   input in,    // input signal
   input areset, // asynchronous reset signal
   output out   // output signal
);

   // declare the state enumeration
   typedef enum logic [1:0] {
      STATE_B = 2'b00,
      STATE_A = 2'b01
   } state_t;

   // declare the state register and next state register
   reg state_t state_reg, next_state_reg;


   always_ff @(posedge clk or posedge areset) begin
      if (areset) begin
         // asynchronously reset to state B
         state_reg <= STATE_B;
      end else begin
         // transition logic
         state_reg <= next_state_reg;
      end
   end


   always_comb begin
      // default next state is the current state
      next_state_reg = state_reg;

      case (state_reg)
         STATE_B: begin
            case (in)
               1'b0: next_state_reg = STATE_A;
               1'b1: next_state_reg = STATE_B;
            endcase
         end

         STATE_A: begin
            case (in)
               1'b0: next_state_reg = STATE_B;
               1'b1: next_state_reg = STATE_A;
            endcase
         end
      endcase
   end


   // output logic
   assign out = (state_reg == STATE_A) ? 1'b1 : 1'b0;

endmodule
