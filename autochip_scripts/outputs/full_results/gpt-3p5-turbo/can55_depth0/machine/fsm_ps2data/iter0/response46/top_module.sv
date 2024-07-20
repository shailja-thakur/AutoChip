module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes, // Added "reg" to make out_bytes a register
  output reg done // Added "reg" to make done a register
);

  // Define states
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;

  // Define current state and next state variables
  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1; // Initialize state to BYTE1 when reset is active
      out_bytes <= 24'h000000; // Initialize out_bytes to 0 when reset is active
      done <= 0; // Initialize done to 0 when reset is active
    end else begin
      state <= next_state; // Update state with next_state on clock edges
      out_bytes <= {out_bytes[15:0], in}; // Shift in the input to the register

      // Determine next state based on current state and input
      case(state)
        BYTE1: begin
          if (in[2] == 1'b1)
            next_state = BYTE2;
          else
            next_state = BYTE1;
        end
        BYTE2: begin
          next_state = BYTE3;
        end
        BYTE3: begin
          next_state = DONE;
        end
        DONE: begin
          if (in[2] == 1'b0)
            next_state = BYTE1;
          else
            next_state = DONE;
        end
      endcase
    end
  end

  // Set done signal based on state
  always @(state) begin
    if (state == DONE)
      done = 1'b1;
    else
      done = 1'b0;
  end

endmodule
