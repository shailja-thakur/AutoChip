module top_module (
	input clk,
	input reset,
	input w,
	output z
);

  reg [2:0] state, next_state;

  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;

  // State flip-flops
  always @(posedge clk, posedge reset)
  begin
    if (reset)
      state <= A;
    else
      state <= next_state;
  end

  // State table
  always @(*)
  begin
    case(state)
      A: if (w) next_state = B; else next_state = A;
      B: if (w) next_state = C; else next_state = D;
      C: if (w) next_state = E; else next_state = D;
      D: if (w) next_state = F; else next_state = A;
      E: if (z) next_state = E; else next_state = D;
      F: if (z) next_state = C; else next_state = D;
      default: next_state = A;
    endcase
  end

  // Output assignment
  assign z = (state == E) ? 1'b1 : 1'b0;

endmodule
