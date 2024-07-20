module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg [7:0] byte1, byte2, byte3;
  wire is_first_byte;
  reg [2:0] next_state;

  assign is_first_byte = in[3] && (state == 0);

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else
      state <= next_state;
  end

  always @* begin
    next_state = state;
    case (state)
      0: begin
        next_state = is_first_byte ? 1 : 0;  // Transition to state 1 if first byte
      end
      1: begin
        byte1 <= in;
        next_state = 2;  // Transition to state 2
      end
      2: begin
        byte2 <= in;
        next_state = 3;  // Transition to state 3
      end
      3: begin
        byte3 <= in;
        next_state = 0;  // Transition back to state 0
      end
      default: next_state = 0;
    endcase
  end

  assign done = (state == 0) && (next_state == 3);

endmodule
