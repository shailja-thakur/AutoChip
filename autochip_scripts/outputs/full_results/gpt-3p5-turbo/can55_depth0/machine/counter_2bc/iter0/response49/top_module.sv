module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output wire [1:0] state
);
   
   // Declare internal signals
   reg [1:0] current_state, next_state;

   // Define state encoding
   parameter S0 = 2'b00; // State 0
   parameter S1 = 2'b01; // State 1
   parameter S2 = 2'b10; // State 2
   parameter S3 = 2'b11; // State 3
   
   // Sequential logic for state transitions
   always @(posedge clk, posedge areset)
   begin
      if (areset)
         current_state <= S1; // Reset to state 1
      else if (train_valid)
      begin
         case (current_state)
            S0: next_state <= train_taken ? S1 : S0;
            S1: next_state <= train_taken ? S2 : S0;
            S2: next_state <= train_taken ? S3 : S1;
            S3: next_state <= train_taken ? S3 : S2;
         endcase
      end
   end
   
   // Combinational logic for outputs
   always @(*)
   begin
      case (current_state)
         S0: state <= 2'b00;
         S1: state <= 2'b01;
         S2: state <= 2'b10;
         S3: state <= 2'b11;
      endcase
   end
   
endmodule
