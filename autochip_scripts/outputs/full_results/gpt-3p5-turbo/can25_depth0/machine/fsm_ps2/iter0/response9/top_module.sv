module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // State declarations
  reg [1:0] state;

  // State definitions
  localparam BYTE1 = 2'b00;
  localparam BYTE2 = 2'b01;
  localparam BYTE3 = 2'b10;
  localparam DONE = 2'b11;

  // Register to store the previous third bit value
  reg prev_bit;

  // Always block for the state machine
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1; // Reset to starting state BYTE1

    // State transitions
    end else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1'b1) begin
            state <= BYTE2;
          end
        end

        BYTE2: begin
          state <= BYTE3;
        end

        BYTE3: begin
          state <= DONE;
        end

        DONE: begin
          if (in[2] == 1'b0) begin
            state <= BYTE1;
          end else begin
            state <= BYTE2;
          end
        end
      endcase
    end
  end

  // Assign done signal based on the current state
  assign done = (state == DONE);

endmodule
