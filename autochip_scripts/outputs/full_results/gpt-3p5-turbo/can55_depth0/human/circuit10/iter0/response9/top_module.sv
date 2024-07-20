module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

  reg state;
  reg q;
  reg next_state;
  reg next_q;

  always @(posedge clk) begin
    state <= next_state;
    q <= next_q;
  end

  always @(a, b, state) begin
    case (state)
      0: begin
        next_state = (a & b) ? 1 : 0;
        next_q = 0;
      end
      1: begin
        next_state = 1;
        next_q = a;
      end
    endcase
  end

endmodule
