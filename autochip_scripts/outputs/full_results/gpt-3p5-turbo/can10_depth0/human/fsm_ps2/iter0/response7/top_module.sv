module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  // Define the states of the FSM
  typedef enum logic [1:0] {
    IDLE,
    BYTE1,
    BYTE2,
    BYTE3
  } state_t;
  
  // Define the signals and registers
  state_t state, next_state;
  logic [7:0] byte1, byte2, byte3;
  
  // Assign the initial state and signals
  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      byte1 <= 8'h00;
      byte2 <= 8'h00;
      byte3 <= 8'h00;
    end else begin
      state <= next_state;
      
      // Store the received byte in the respective register
      case (state)
        BYTE1: byte1 <= in;
        BYTE2: byte2 <= in;
        BYTE3: byte3 <= in;
      endcase
    end
  end
  
  // Assign the next state and done signal
  always_comb begin
    done = 0;
    next_state = state;
    
    case (state)
      IDLE: begin
        // Check if the current byte has in[3]=1
        if (in[3] == 1) begin
          next_state = BYTE1;
        end
      end
      
      BYTE1: begin
        // Store the byte and check for next state conditions
        byte1 = in;
        
        // Check if the next byte has in[3]=1
        if (in[3] == 1) begin
          next_state = BYTE2;
        end
      end
      
      BYTE2: begin
        // Store the byte and check for next state conditions
        byte2 = in;
        
        // Check if the next byte has in[3]=1
        if (in[3] == 1) begin
          next_state = BYTE3;
        end
      end
      
      BYTE3: begin
        // Store the byte and set done signal
        byte3 = in;
        done = 1;
      end
    endcase
  end
endmodule
