module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define the states
  typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
  } state_t;

  // Registers to store the current state and next state
  reg state_t current_state;
  reg state_t next_state;

  // Assign initial state
  initial begin
    current_state = BYTE1;
    next_state = BYTE1;
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= BYTE1;
    end else begin
      current_state <= next_state;
    end
  end

  // Output done signal when in DONE state
  assign done = (current_state == DONE);

  // State transition logic
  always @(current_state) begin
    case (current_state)
      BYTE1: begin
        if (in[2] == 1) begin
          next_state = BYTE2;
        end else begin
          next_state = BYTE1;
        end
      end
      BYTE2: begin
        next_state = BYTE3;
      end
      BYTE3: begin
        next_state = DONE;
      end
      DONE: begin
        if (in[2] == 1) begin
          next_state = BYTE2;
        end else begin
          next_state = BYTE1;
        end
      end
    endcase
  end

endmodule
