module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
  reg [2:0] state, next_state;
  wire [2:0] state_next;
  reg output_reg;
  wire output_next;

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

  // Assign next state using combinational logic
  always @*
  begin
    state_next = state;
    output_next = output_reg;
    case(state)
      A: if (w) state_next = B; else state_next = A;
      B: if (w) state_next = C; else state_next = D;
      C: if (w) state_next = E; else state_next = D;
      D: if (w) state_next = F; else state_next = A;
      E: if (output_reg) state_next = E; else state_next = D;
      F: if (output_reg) state_next = C; else state_next = D;
      default: state_next = A;
    endcase
  end

  // Output assignment
  always @(posedge clk)
  begin
    if (state == E)
      output_reg <= 1'b1;
    else
      output_reg <= 1'b0;
  end

  // Synchronous assignment of next state and output
  always @(posedge clk)
  begin
    if (reset)
      next_state <= A;
    else
      next_state <= state_next;
    
    output_reg <= output_next;
  end

  // Output assignment
  assign z = output_reg;

endmodule
