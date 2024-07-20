module top_module (
    input clk,
    input areset,
    input x,
    output z
);
  
  // Define state and output reg variables
  reg [2:0] state;
  reg z;
  
  // Define state values
  parameter S_IDLE = 3'b000;
  parameter S_CONVERTING = 3'b001;
  parameter S_DONE = 3'b010;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Reset the state and output
      state <= S_IDLE;
      z <= 0;
    end else begin
      case (state)
        S_IDLE: begin
          // Transition to conversion state when reset is released
          if (!areset)
            state <= S_CONVERTING;
        end
        
        S_CONVERTING: begin
          // Perform the 2's complement conversion
          z <= ~x + 1;
          
          // Transition to done state when input is zero
          if (x == 0)
            state <= S_DONE;
        end
        
        S_DONE: begin
          // Stay in done state until reset is asserted
          if (areset)
            state <= S_IDLE;
        end
      endcase
    end
  end
endmodule
