module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  
  // Define the states
  parameter A = 2'b00;  // Define the binary encoding for state A
  parameter B = 2'b01;  // Define the binary encoding for state B
  parameter C = 2'b10;  // Define the binary encoding for state C
  parameter D = 2'b11;  // Define the binary encoding for state D
  
  // Define the state register and next state signals
  reg [1:0] state_reg, next_state;
  
  // Define the output signal
  reg out_reg;
  
  // Sequential logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset
      state_reg <= A;  // Reset the state machine to state A
    end else begin
      // Positive edge triggered clocked logic
      state_reg <= next_state;  // Update the state register with the next state
    end
  end
  
  // Combinational logic
  always @* begin
    case (state_reg)
      A: begin
        if (in) begin
          next_state = B;  // Next state if input is 1
        end else begin
          next_state = A;  // Next state if input is 0
        end
        out_reg = 1'b0;
      end
      
      B: begin
        if (in) begin
          next_state = B;  // Next state if input is 1
        end else begin
          next_state = C;  // Next state if input is 0
        end
        out_reg = 1'b0;
      end
      
      C: begin
        if (in) begin
          next_state = D;  // Next state if input is 1
        end else begin
          next_state = A;  // Next state if input is 0
        end
        out_reg = 1'b0;
      end
      
      D: begin
        if (in) begin
          next_state = B;  // Next state if input is 1
        end else begin
          next_state = C;  // Next state if input is 0
        end
        out_reg = 1'b1;
      end
      
      default: begin  // Default case
        next_state = A;  // Default to state A
        out_reg = 1'b0;  // Default output is 0
      end
    endcase
  end
  
  // Assign the output signal
  assign out = out_reg;
  
endmodule
