module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  // State enumeration
  localparam A = 0;
  localparam B = 1;

  // State memory and next state logic
  reg [1:0] state, next_state;
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= B;
    else
      state <= next_state;
  end

  // Output logic
  always @(state) begin
    case (state)
      A: out = 0;
      B: out = 1;
    endcase
  end

  // State transition logic
  always @(state, in) begin
    case (state)
      A: next_state = in ? A : B;
      B: next_state = in ? B : A;
    endcase
  end

endmodule
