module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  
  // State definitions
  parameter B = 2'b00;
  parameter A = 2'b01;

  // Next-state logic
  always @(posedge clk, negedge areset) begin
    if (areset)
      state <= B;
    else begin
      case (state)
        B: if (in) state <= B; else state <= A;
        A: if (in) state <= A; else state <= B;
      endcase
    end
  end

  // Output logic
  always @(state) begin
    case (state)
      B: out = 1'b1;
      A: out = 1'b0;
    endcase
  end

endmodule
