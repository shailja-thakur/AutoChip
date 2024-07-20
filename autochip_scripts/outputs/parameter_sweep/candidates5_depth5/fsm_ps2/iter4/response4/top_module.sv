module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [2:0] state;
  reg byte1_received;
  wire [7:0] in_reg;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      byte1_received <= 1'b0;
      done <= 1'b0;
    end else begin
      state <= state; // Hold current state until state update is determined

      // Register input value to be used in the next state
      in_reg <= in;

      case (state)
        3'b000: begin // Idle state
          if (in_reg[3]) begin  // Check if byte 1 of a message
            state <= 3'b001;
            byte1_received <= 1'b1;
          end
        end
        3'b001: begin // Byte 1 received
          if (in[3] && !byte1_received) begin  // Check if byte 2 of a message
            state <= 3'b010;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end
        end
        3'b010: begin // Byte 2 received
          if (in[3] && byte1_received) begin  // Check if byte 3 of a message
            state <= 3'b011;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end
        end
        3'b011: begin // Byte 3 received
          state <= 3'b000; // Go back to idle state
          byte1_received <= 1'b0;
          done <= 1'b1;
        end
      endcase
    end
  end

endmodule
