module top_module (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

  // assign statements for next_state ports
  always @(state or in) begin
    // assigns values to next_state[A]
    if (in == 1'b0) begin
      next_state[0] <= state[0] | state[2];
    end
    else begin
      next_state[0] <= 1'b0;
    end

    // assigns values to next_state[B]
    if (in == 1'b0) begin
      next_state[1] <= 1'b0;
    end
    else begin
      next_state[1] <= state[0] | state[1] | state[3];
    end

    // assigns values to next_state[C]
    if (in == 1'b0) begin
      next_state[2] <= state[1] | state[3];
    end
    else begin
      next_state[2] <= 1'b0;
    end

    // assigns values to next_state[D]
    if (in == 1'b0) begin
      next_state[3] <= 1'b0;
    end
    else begin
      next_state[3] <= state[2];
    end
  end

  // assign statement for out port
  always @(state) begin
    out <= state[3];
  end

endmodule
