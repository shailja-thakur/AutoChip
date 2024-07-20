module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
  
  // Define states in the FSM
  typedef enum logic [1:0] {
    IDLE,
    BYTE1,
    BYTE2,
    BYTE3
  } state_t;
  
  state_t state, next_state;
  
  // Register to store the last received byte
  logic [7:0] last_byte;
  
  // FSM logic
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= IDLE;
      done <= 0;
    end
    else begin
      state <= next_state;
      done <= 0;
      
      case (state)
        IDLE:
          if (in[3]) begin
            next_state <= BYTE1;
          end
          
        BYTE1:
          if (in[3]) begin
            next_state <= BYTE2;
          end
          else begin
            next_state <= BYTE1;
          end
          
        BYTE2:
          if (in[3]) begin
            next_state <= BYTE3;
          end
          else begin
            next_state <= BYTE1;
          end
          
        BYTE3:
          if (in[3]) begin
            next_state <= BYTE1;
            done <= 1;
          end
          else begin
            next_state <= BYTE1;
          end
      endcase
    end
  end
  
  // Output last_byte register
  always_comb begin
    case (state)
      IDLE: last_byte = 8'bzzzz_zzzz;
      BYTE1: last_byte = in;
      BYTE2: last_byte = in;
      BYTE3: last_byte = in;
    endcase
  end
  
endmodule
