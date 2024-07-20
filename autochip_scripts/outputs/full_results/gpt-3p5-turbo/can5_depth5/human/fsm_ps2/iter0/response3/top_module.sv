module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    done <= 0;
  end
  else begin
    case(state)
      0: begin
        if (in[3] == 1) begin
          byte1 <= in;
          state <= 1;
        end
      end
      1: begin
        byte2 <= in;
        state <= 2;
      end
      2: begin
        state <= 0;
        done <= 1;
      end
    endcase
  end
end

endmodule
