module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  // Internal states
  reg [2:0] state;

  // Start bit parameter
  parameter START_BIT = 1'b0;

  // Data bit parameters
  parameter DATA_BITS = 8;
  reg [DATA_BITS - 1:0] data;
  reg [DATA_BITS - 1:0] count;

  // Stop bit parameter
  parameter STOP_BIT = 1'b1;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the FSM and output values
      state <= 3'b0;
      out_byte <= 8'b0;
      done <= 1'b0;
      data <= {DATA_BITS{1'b0}};
      count <= {DATA_BITS{1'b1}};
    end else begin
      case (state)
        // Wait for idle state
        3'b000: begin
          if (in == STOP_BIT) begin
            // Start bit detected, transition to receive state
            state <= 3'b001;
          end
        end

        // Receive state
        3'b001: begin
          // Shift data bits
          data <= {data[DATA_BITS - 2:0], in};

          // Decrement count
          count <= count - 1;

          if (count == 0) begin
            // All data bits received, transition to verify state
            state <= 3'b010;
          end
        end

        // Verify state
        3'b010: begin
          if (in == STOP_BIT) begin
            // Stop bit detected, output received byte
            out_byte <= data;
            done <= 1'b1;

            // Transition back to idle state
            state <= 3'b000;
          end else begin
            // Stop bit not detected, wait for next stop bit
            state <= 3'b011;
          end
        end

        // Wait for next stop bit
        3'b011: begin
          if (in == STOP_BIT) begin
            // Stop bit detected, transition to receive state for next byte
            state <= 3'b001;
          end
        end

        default: state <= 3'b000;
      endcase
    end
  end

endmodule
