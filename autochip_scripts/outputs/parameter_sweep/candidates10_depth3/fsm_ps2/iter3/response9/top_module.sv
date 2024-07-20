module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
wire is_first_byte;
reg done_reg;

assign is_first_byte = in[3] && (state == 0);

always @(posedge clk) begin
  if (reset)
    state <= 0;
    done_reg <= 0;
  else begin
    case (state)
      0: begin
        if (is_first_byte)
          state <= 1;  // Transition to state 1 if first byte
      end
      1: begin
        byte1 <= in;
        state <= 2;  // Transition to state 2
      end
      2: begin
        byte2 <= in;
        state <= 3;  // Transition to state 3
      end
      3: begin
        byte3 <= in;
        state <= 0;  // Transition back to state 0
        done_reg <= 1;
      end
      default: begin
        state <= 0;
        done_reg <= 0;
      end
    endcase
  end
end

always @(posedge clk) begin
  done <= done_reg;
end

endmodule
