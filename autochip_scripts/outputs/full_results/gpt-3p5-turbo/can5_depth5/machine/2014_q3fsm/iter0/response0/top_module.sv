module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

  reg [3:0] state, next_state;

  // State assignments
  assign s = (state == 0);
  assign w = (state == 1);
  assign z = (state == 2);

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else
      state <= next_state;
  end

  always @* begin
    case(state)
      0: begin // state A
        next_state = (s) ? 1 : state;
      end
      1: begin // state B
        next_state = (w) ? 3 : 2;
      end
      2: begin // state C
        next_state = (w) ? 3 : 2;
      end
      3: begin // state S10
        next_state = (w) ? 5 : 4;
      end
      4: begin // state S11
        next_state = (w) ? 6 : 5;
      end
      5: begin // state S20
        next_state = 1;
      end
      6: begin // state S21
        next_state = (w) ? 2 : 1;
      end
      7: begin // state S22
        next_state = (w) ? 1 : 2;
      end
      default: next_state = state;
    endcase
  end

endmodule
