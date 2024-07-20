module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    done <= 0;
  end else begin
    case(state)
      0: begin // Wait for the first byte with in[3]=1
        if (in[3]) begin
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
      3: begin // Check if all 3 bytes have been received
        if (in[3]) begin
          done <= 1;
        end
        state <= 0;
      end
    endcase
  end
end

endmodule
