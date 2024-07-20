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

  // Declare the state and next_state variables
  state_t state, next_state;

  // Declare the internal register for storing the third bit of the input
  reg third_bit;

  // Assign the initial state
  initial begin
    state = BYTE1;
  end

  // Assign the next_state based on the current state and input values
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
    end else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1'b1) begin
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
          if (in[2] == 1'b1) begin
            next_state = BYTE2;
          end else begin
            next_state = BYTE1;
          end
        end
      endcase
    end
  end

  // Update the current state with the next_state at the positive edge of the clock
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
    end else begin
      state <= next_state;
    end
  end

  // Output the done signal when in the DONE state
  assign done = (state == DONE);

endmodule
