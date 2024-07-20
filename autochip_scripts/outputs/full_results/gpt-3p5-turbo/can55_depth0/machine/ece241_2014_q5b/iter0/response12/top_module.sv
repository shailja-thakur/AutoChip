module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  // Parameter declaration
  parameter A = 0;
  parameter B = 1;

  // State declaration
  reg [1:0] state;

  // Output assignment
  assign z = (state == A && x) || (state == B && !x);

  // State machine logic
  always @(posedge clk or negedge areset) begin
    if (!areset)
      state <= A;
    else begin
      case (state)
        A: begin
          if (x)
            state <= B;
          else
            state <= A;
        end
        B: begin
          state <= B;
        end
      endcase
    end
  end

endmodule
