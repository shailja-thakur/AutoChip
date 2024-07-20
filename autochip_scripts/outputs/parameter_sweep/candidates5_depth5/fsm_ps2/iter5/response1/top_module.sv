module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [2:0] state;
  reg byte1_received;
  reg byte2_received;
  reg [2:0] counter;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      byte1_received <= 1'b0;
      byte2_received <= 1'b0;
      done <= 1'b0;
      counter <= 3'b000;
    end else begin
      case (state)
        3'b000: begin
          if (in[3]) begin  // Check if byte 1 of a message
            state <= 3'b001;
            byte1_received <= 1'b1;
          end
        end
        3'b001: begin
          if (in[3] && !byte1_received) begin  // Check if byte 2 of a message
            state <= 3'b010;
            byte2_received <= 1'b1;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end
        end
        3'b010: begin
          if (in[3] && byte1_received && !byte2_received) begin  // Check if byte 3 of a message
            state <= 3'b011;
          end else if (!in[3] && byte1_received) begin  // Reset if byte 1 is not received
            state <= 3'b000;
            byte1_received <= 1'b0;
          end
        end
        3'b011: begin
          state <= 3'b000;  // Go back to the idle state
          byte1_received <= 1'b0;
          byte2_received <= 1'b0;
          
          // Done is only set when all 3 bytes are received
          if (counter == 3'b010)
            done <= 1'b1;
          else
            done <= 1'b0;
        end
      endcase
      
      // Increment the counter if a byte is received
      if (in[3])
        counter <= counter + 1'b1;
    end
  end
endmodule
