module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define the states
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;
  
  // Define the state register
  reg [1:0] state;
  
  // Define the output register
  reg done_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1; // Initialize the state to BYTE1
      done_reg <= 1'b0; // Reset the done signal
    end else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1'b1) begin
            state <= BYTE2; // Transition to BYTE2 state if third bit is 1
          end
        end
        BYTE2: begin
          state <= BYTE3; // Transition to BYTE3 state
        end
        BYTE3: begin
          state <= DONE; // Transition to DONE state
        end
        DONE: begin
          if (in[2] == 1'b0) begin
            state <= BYTE1; // Transition back to BYTE1 state if third bit is 0
          end else begin
            state <= BYTE2; // Transition back to BYTE2 state if third bit is 1
          end
        end
      endcase
    end
  end
  
  // Assign done signal based on the state
  assign done = (state == DONE);
  
endmodule
