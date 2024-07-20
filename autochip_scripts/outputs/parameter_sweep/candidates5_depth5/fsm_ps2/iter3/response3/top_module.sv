module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [1:0] state;
  reg byte0_received;
  reg byte1_received;
  reg byte2_received;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
      byte0_received <= 1'b0;
      byte1_received <= 1'b0;
      byte2_received <= 1'b0;
      done <= 1'b0;
    end else begin
      case (state)
        2'b00: begin // Idle state
          if (in[3]) begin  // Check if byte 1 of a message
            state <= 2'b01;
            byte0_received <= 1'b1;
          end
        end
        2'b01: begin // Byte 0 received
          if (!in[3]) begin  // Reset if byte 1 is not received
            state <= 2'b00;
            byte0_received <= 1'b0;
          end else if (!byte1_received) begin
            state <= 2'b10;
            byte1_received <= 1'b1;
          end
        end
        2'b10: begin // Byte 1 received
          if (!in[3]) begin  // Reset if byte 1 is not received
            state <= 2'b00;
            byte0_received <= 1'b0;
            byte1_received <= 1'b0;
          end else if (!byte2_received) begin
            state <= 2'b11;
            byte2_received <= 1'b1;
          end
        end
        2'b11: begin // Byte 2 received
          state <= 2'b00; // Go back to idle state
          byte0_received <= 1'b0;
          byte1_received <= 1'b0;
          byte2_received <= 1'b0;
          done <= 1'b1;
        end
      endcase
    end
  end

endmodule
