module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [2:0] state;
  reg byte1_received;
  reg byte2_received;
  reg [1:0] count;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      byte1_received <= 1'b0;
      byte2_received <= 1'b0;
      count <= 2'b00;
      done <= 1'b0;
    end else begin
      case (state)
        3'b000: begin // Idle state
          if (in[3]) begin  // Check if byte 1 of a message
            state <= 3'b001;
            byte1_received <= 1'b1;
          end
        end
        3'b001: begin // Byte 1 received
          if (in[3] && !byte1_received) begin  // Check if byte 2 of a message
            state <= 3'b010;
            byte2_received <= 1'b1;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end else if (byte1_received && !in[3]) begin
            state <= 3'b000;
          end
        end
        3'b010: begin // Byte 2 received
          if (in[3] && byte1_received && !byte2_received) begin  // Check if byte 3 of a message
            state <= 3'b011;
            count <= 2'b00;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end else if (!in[3] && !byte1_received) begin
            state <= 3'b000;
          end
        end
        3'b011: begin // Byte 3 received
          if (count == 2'b11) begin
            state <= 3'b000; // Go back to idle state
            byte1_received <= 1'b0;
            byte2_received <= 1'b0;
            done <= 1'b1;
          end else begin
            state <= 3'b010; // Go back to byte 2 received state
            count <= count + 1;
          end
        end
      endcase
    end
  end

endmodule
