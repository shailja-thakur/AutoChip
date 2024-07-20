module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  // Define states
  typedef enum logic [1:0] {
    WAIT,
    BYTE1,
    BYTE2,
    BYTE3
  } state_t;
  
  // Create state and next_state variables
  state_t state;
  state_t next_state;
  
  // Create done signal
  reg done;
  
  // Create register to store previous value of in[3]
  reg in3_prev;
  
  // Create counter to keep track of bytes received
  reg [1:0] byte_count;
  
  // Synchronous reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= WAIT;
      done <= 0;
    end else begin
      state <= next_state;
      done <= (state == BYTE3);
    end
  end
  
  // Combinational logic to determine next state and output signals
  always @(in, state) begin
    case (state)
      WAIT: begin
        next_state = (in[3]) ? BYTE1 : WAIT;
      end
      BYTE1: begin
        next_state = BYTE2;
      end
      BYTE2: begin
        next_state = BYTE3;
      end
      BYTE3: begin
        next_state = WAIT;
      end
      default: begin
        next_state = WAIT;
      end
    endcase
    
    in3_prev = in[3]; // Store the current value of in[3] for the next clock cycle
    
    if (byte_count == 2) begin
      byte_count <= 0;
    end else if (state != WAIT && in3_prev && !in[3]) begin
      byte_count <= byte_count + 1;
    end
  end
  
endmodule
