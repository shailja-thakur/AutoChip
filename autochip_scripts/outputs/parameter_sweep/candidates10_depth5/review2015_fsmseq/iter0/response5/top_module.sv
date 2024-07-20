module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

  // Define the states of the finite-state machine
  typedef enum logic [1:0] {
    S0,
    S1,
    S2,
    S3,
    S4
  } state_t;

  // Define the current state and next state variables
  state_t current_state;
  state_t next_state;

  // Define the signals for comparing the input sequence
  logic [3:0] input_seq;

  // Define the start shifting signal
  reg start_shifting;

  // Synchronous reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= S0;
      input_seq <= 0;
      start_shifting <= 0;
    end else begin
      current_state <= next_state;
      input_seq <= {input_seq[2:0], data};
      start_shifting <= (current_state == S4);
    end
  end

  // Combinational logic to determine the next state
  always @* begin
    case (current_state)
      S0: if (input_seq == 4'b1_1_0_1) next_state = S1; else next_state = S0;
      S1: if (input_seq == 4'b1_1_0_1) next_state = S1; else next_state = S2;
      S2: if (input_seq == 4'b1_1_0_1) next_state = S1; else next_state = S2;
      S3: if (input_seq == 4'b1_1_0_1) next_state = S4; else next_state = S2;
      S4: if (input_seq == 4'b1_1_0_1) next_state = S1; else next_state = S2;
    endcase
  end

endmodule
