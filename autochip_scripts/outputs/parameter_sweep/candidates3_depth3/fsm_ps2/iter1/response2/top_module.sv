module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

reg [2:0] state; // FSM state register
reg [7:0] byte_cnt; // Counter to keep track of the number of bytes received in the message

always @(posedge clk or posedge reset) begin
  if (reset) begin // Reset condition
    state <= 0;
    byte_cnt <= 0;
    done <= 0;
  end else begin // FSM states
    case (state)
      0: begin // Initial state
        if (in[3] == 1) begin
          state <= 1; // Move to state 1 if in[3] is 1
          byte_cnt <= 1; // Increment byte count to 1
        end else begin
          state <= 0; // Stay in state 0 if in[3] is 0
          byte_cnt <= 0; // Reset byte count
          done <= 0; // Reset done signal
        end
      end
      1: begin // State 1 - Expecting Byte 2
        if (in[3] == 0) begin
          state <= 2; // Move to state 2 if in[3] is 0
          byte_cnt <= 2; // Increment byte count to 2
        end else begin
          state <= 0; // Return to state 0 if in[3] is 1
          byte_cnt <= 0; // Reset byte count
          done <= 0; // Reset done signal
        end
      end
      2: begin // State 2 - Expecting Byte 3
        if (in[3] == 0) begin
          state <= 0; // Return to state 0 if in[3] is 0
          byte_cnt <= 0; // Reset byte count
          done <= 1; // Set done high to signal receipt of a message
        end else begin
          state <= 0; // Return to state 0 if in[3] is 1
          byte_cnt <= 0; // Reset byte count
          done <= 0; // Reset done signal
        end
      end
    endcase
  end
end

endmodule
