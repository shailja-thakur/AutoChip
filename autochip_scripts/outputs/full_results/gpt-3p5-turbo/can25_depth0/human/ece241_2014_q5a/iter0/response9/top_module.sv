module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  reg [31:0] count; // Counter to keep track of the number of bits processed
  
  reg signed [31:0] sum; // Register to hold the sum

  // State encoding
  parameter S_IDLE = 2'b00;
  parameter S_ADD_X = 2'b01;
  parameter S_OUTPUT = 2'b10;
  
  reg [1:0] state; // State register
  
  // State machine logic
  always @(posedge clk, posedge areset)
  begin
    if (areset)
    begin
      state <= S_IDLE; // Reset the state to idle
      count <= 0; // Reset the counter
      sum <= 0; // Reset the sum
    end
    else
    begin
      case (state)
        S_IDLE:
        begin
          if (~areset)
          begin
            state <= S_ADD_X; // Transition to the add X state
            sum <= x;
          end
        end
        
        S_ADD_X:
        begin
          if (count < 31)
          begin
            state <= S_ADD_X; // Stay in the add X state
            count <= count + 1; // Increment the counter
            sum <= sum + x; // Add X to the sum
          end
          else
          begin
            state <= S_OUTPUT; // Transition to the output state
            count <= 0; // Reset the counter
            sum <= sum + x; // Add X to the sum
          end
        end
        
        S_OUTPUT:
        begin
          if (count < 31)
          begin
            state <= S_OUTPUT; // Stay in the output state
            count <= count + 1; // Increment the counter
          end
          else
          begin
            state <= S_IDLE; // Transition back to the idle state
            count <= 0; // Reset the counter
          end
        end
      endcase
    end
  end

  // Output logic
  assign z = sum;

endmodule
