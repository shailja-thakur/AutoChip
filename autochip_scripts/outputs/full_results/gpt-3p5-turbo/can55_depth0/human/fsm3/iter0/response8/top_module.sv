module top_module (
	input clk,
	input in,
	input areset,
	output out
);

  reg [1:0] state, next_state;
  reg out;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'bA;
    else
      state <= next_state;
  end
  
  always @(state or in) begin
    case (state)
      2'bA: begin
        if (in)
          next_state <= 2'bB;
        else
          next_state <= 2'bA;
        out <= 1'b0;
      end
      2'bB: begin
        if (in)
          next_state <= 2'bB;
        else
          next_state <= 2'bC;
        out <= 1'b0;
      end
      2'bC: begin
        if (in)
          next_state <= 2'bD;
        else
          next_state <= 2'bA;
        out <= 1'b0;
      end
      2'bD: begin
        if (in)
          next_state <= 2'bB;
        else
          next_state <= 2'bC;
        out <= 1'b1;
      end
      default: begin
        next_state <= 2'bA;
        out <= 1'b0;
      end
    endcase
  end
  
endmodule
