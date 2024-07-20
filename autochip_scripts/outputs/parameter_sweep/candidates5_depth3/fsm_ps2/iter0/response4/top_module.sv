module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk) begin
  if (reset) begin
    state <= 2'b00;
    done <= 0;
  end else begin
    case (state)
      2'b00: begin // Idle state, waiting for start of message
        if (in[3] == 1) begin
          byte1 <= in;
          state <= 2'b01; // Transition to receiving byte 2
        end
      end
      2'b01: begin // Receiving byte 2
        byte2 <= in;
        state <= 2'b10; // Transition to receiving byte 3
      end
      2'b10: begin // Receiving byte 3
        byte3 <= in;
        state <= 2'b00; // Transition back to idle state
        done <= 1; // Signal that a message has been received
      end
      default: begin // Error state, should not be reached
        state <= 2'b00;
        done <= 0;
      end
    endcase
  end
end

endmodule
