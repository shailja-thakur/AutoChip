module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
reg [7:0] in_reg;
wire is_first_byte;


assign is_first_byte = (in_reg[3] == 1) && (state == 0);

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 0;
    done <= 0;
  else begin
    in_reg <= in;
    case (state)
      0: begin
        state <= is_first_byte ? 1 : 0;  // Transition to state 1 if first byte
      end
      1: begin
        byte1 <= in_reg;
        state <= 2;  // Transition to state 2
      end
      2: begin
        byte2 <= in_reg;
        state <= 3;  // Transition to state 3
      end
      3: begin
        byte3 <= in_reg;
        state <= 0;  // Transition back to state 0
        done <= 1;   // Signal done
      end
      default: state <= 0;
    endcase
  end
end

endmodule
