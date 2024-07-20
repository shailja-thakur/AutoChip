module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define the states
  typedef enum logic [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_type;
  
  // Declare the state variable
  state_type state;
  
  // Declare a temporary variable to store the input's 3rd bit
  wire input_bit_3;
  
  // Assign the 3rd bit of the input to the temporary variable
  assign input_bit_3 = in[2];
  
  // Declare a register to hold the next state
  reg [1:0] next_state;
  
  // Declare registers for the state machine
  reg [1:0] current_state;
  reg done_reg;
  
  // Sequential logic block
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= BYTE1;
      done_reg <= 0;
    end else begin
      current_state <= next_state;
      done_reg <= (current_state == DONE);
    end
  end
  
  // Combinational logic block
  always @* begin
    case (current_state)
      
      BYTE1: begin
        if (input_bit_3 == 1'b0) begin
          next_state = BYTE1;
        end else begin
          next_state = BYTE2;
        end
      end
      
      BYTE2: begin
        next_state = BYTE3;
      end
      
      BYTE3: begin
        next_state = DONE;
      end
      
      DONE: begin
        if (input_bit_3 == 1'b0) begin
          next_state = BYTE1;
        end else begin
          next_state = BYTE2;
        end
      end
      
    endcase
  end
  
  // Assign the done signal
  assign done = done_reg;
  
endmodule
