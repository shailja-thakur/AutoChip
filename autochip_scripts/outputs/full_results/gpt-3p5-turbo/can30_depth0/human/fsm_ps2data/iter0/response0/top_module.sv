module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg [1:0] state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    byte1 <= 0;
    byte2 <= 0;
    byte3 <= 0;
    out_bytes <= 0;
    done <= 0;
  end else begin
    case (state)
      0: begin // searching for byte1
        if (in[3] == 1) begin
          state <= 1;
          byte1 <= in;
        end
      end
      1: begin // searching for byte2
        if (in[3] == 0) begin
          state <= 2;
          byte2 <= in;
        end
      end
      2: begin // searching for byte3 and signaling done
        if (in[3] == 0) begin
          state <= 0;
          byte3 <= in;
          out_bytes <= {byte1, byte2, byte3};
          done <= 1;
        end
      end
    endcase
  end
end

endmodule
