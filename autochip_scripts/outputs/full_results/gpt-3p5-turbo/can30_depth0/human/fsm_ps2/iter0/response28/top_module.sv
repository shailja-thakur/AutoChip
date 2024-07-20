module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [1:0] state;
  reg [7:0] byte1, byte2, byte3;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      byte1 <= 8'b0;
      byte2 <= 8'b0;
      byte3 <= 8'b0;
    end
    else begin
      case (state)
        2'b00: begin // Wait for in[3] = 1
          if (in[3] == 1'b1) begin
            state <= 2'b01;
            byte1 <= in;
          end
        end
        2'b01: begin // Receive byte1, check for in[3] = 0
          if (in[3] == 1'b0) begin
            state <= 2'b00; // Invalid start, go back to idle state
          end
          else begin
            state <= 2'b10;
            byte2 <= in;
          end
        end
        2'b10: begin // Receive byte2, check for in[3] = 0
          if (in[3] == 1'b0) begin
            state <= 2'b00; // Invalid start, go back to idle state
          end
          else begin
            state <= 2'b11;
            byte3 <= in;
          end
        end
        2'b11: begin // Receive byte3, check for in[3] = 0
          if (in[3] == 1'b0) begin
            state <= 2'b00; // Invalid start, go back to idle state
          end
          else begin
            state <= 2'b00; // Message received successfully, go back to idle state
            done <= 1'b1;
          end
        end
      endcase
    end
  end

endmodule
