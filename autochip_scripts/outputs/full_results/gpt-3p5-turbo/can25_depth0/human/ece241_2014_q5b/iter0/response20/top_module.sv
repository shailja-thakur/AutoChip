module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  // Define the states
  parameter A = 1'b1;
  parameter B = 1'b10;

  // Define the state registe and next state
  reg [1:0] state_reg;
  reg [1:0] state_next;

  // Define output register
  reg z_reg;

  // Define asynchronous reset
  always @(posedge clk or negedge areset) begin
    if (!areset)
      state_reg <= A;
    else
      state_reg <= state_next;
  end

  // Define state and output logic
  always @(state_reg or x) begin
    case(state_reg)
      A: begin
        if(x)
          state_next = B;
        else
          state_next = A;
        z_reg = x;
      end

      B: begin
        if(x)
          state_next = B;
        else
          state_next = B;
        z_reg = ~x;
      end
    endcase
  end

  // Assign output
  assign z = z_reg;

endmodule
