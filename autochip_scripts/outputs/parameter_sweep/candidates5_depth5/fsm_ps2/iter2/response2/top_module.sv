module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [2:0] state;
  reg byte0_received;
  reg byte1_received;
  reg byte2_received;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      done <= 1'b0;
      byte0_received <= 1'b0;
      byte1_received <= 1'b0;
      byte2_received <= 1'b0;
    end else begin
      case (state)
        3'b000: begin // Idle state
          if (in[3]) begin  // Check if byte 0 of a message
            state <= 3'b001;
            byte0_received <= 1'b1;
          end
        end
        3'b001: begin // Byte 0 received
          if (in[3] && byte0_received) begin  // Check if byte 1 of a message
            state <= 3'b010;
            byte1_received <= 1'b1;
          end else if (in[3] && !byte0_received) begin  // Check if byte 0 of a new message
            state <= 3'b001;
            byte0_received <= 1'b1;
          end else if (!in[3]) begin  // Reset
            state <= 3'b000;
            byte0_received <= 1'b0;
          end
        end
        3'b010: begin // Byte 1 received
          if (in[3] && byte1_received) begin  // Check if byte 2 of a message
            state <= 3'b011;
            byte2_received <= 1'b1;
          end else if (in[3] && !byte1_received) begin  // Check if byte 1 of a new message
            state <= 3'b010;
            byte1_received <= 1'b1;
          end else if (!in[3]) begin  // Reset
            state <= 3'b000;
            byte0_received <= 1'b0;
          end
        end
        3'b011: begin // Byte 2 received
          state <= 3'b000; // Go back to idle state
          byte0_received <= 1'b0;
          byte1_received <= 1'b0;
          byte2_received <= 1'b0;
          done <= 1'b1;
        end
      endcase
    end
  end
endmodule
