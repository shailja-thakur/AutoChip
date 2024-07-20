module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state; // FSM state variable
reg [7:0] byte_count; // Counter for number of bytes received

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00; // Reset state
    byte_count <= 8'b00000000; // Reset byte count
    done <= 0; // Reset done signal
  end else begin
    case (state)
      2'b00: begin // Idle state
        if (in[3] == 1) begin
          state <= 2'b01; // Transition to byte 1 state
          byte_count <= 8'b00000001; // Increment byte count
        end
      end
      2'b01: begin // Byte 1 state
        if (byte_count == 8'b00000011) begin
          state <= 2'b10; // Transition to done state
          byte_count <= 8'b00000000; // Reset byte count
          done <= 1; // Signal done
        end else if (in[3] == 1) begin
          state <= 2'b01; // Stay in byte 1 state
          byte_count <= byte_count + 1; // Increment byte count
        end else begin
          state <= 2'b00; // Transition to idle state
          byte_count <= 8'b00000000; // Reset byte count
          done <= 0; // Reset done signal
        end
      end
      2'b10: begin // Done state
        state <= 2'b00; // Transition to idle state
        byte_count <= 8'b00000000; // Reset byte count
        done <= 0; // Reset done signal
      end
    endcase
  end
end

endmodule
