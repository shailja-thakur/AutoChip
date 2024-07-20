module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    out_bytes <= 0;
    done <= 0;
    byte1 <= 0;
    byte2 <= 0;
    byte3 <= 0;
  end else begin
    case (state)
      0: begin // Wait for in[3] to be high
        if (in[3] == 1) begin
          byte1 <= in;
          state <= 1;
        end
      end
      1: begin // Receive byte 2
        byte2 <= in;
        state <= 2;
      end
      2: begin // Receive byte 3
        byte3 <= in;
        state <= 3;
      end
      3: begin // Transmit message
        out_bytes <= {byte1, byte2, byte3};
        done <= 1;
        state <= 0;
      end
    endcase
  end
end

endmodule
