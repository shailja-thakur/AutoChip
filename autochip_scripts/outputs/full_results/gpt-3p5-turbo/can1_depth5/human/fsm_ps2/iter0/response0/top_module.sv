module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg done;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      done <= 0;
    end else begin
      case(state)
        3'b000: begin // Waiting for first byte of message
          if (in[3] == 1) begin
            state <= 3'b001;
          end
        end
        3'b001: begin // Waiting for second byte of message
          state <= 3'b010;
        end
        3'b010: begin // Waiting for third byte of message
          state <= 3'b011;
        end
        3'b011: begin // Done receiving message
          state <= 3'b000;
          done <= 1;
        end
      endcase
    end
  end

endmodule
