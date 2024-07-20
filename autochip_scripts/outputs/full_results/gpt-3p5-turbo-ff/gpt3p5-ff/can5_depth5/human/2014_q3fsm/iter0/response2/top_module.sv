module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
  // Define the states
  parameter A = 0;
  parameter B = 1;
  reg [1:0] state;

  // Initialize the state to A during reset
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= A;
    else
      state <= state;
  end
  
  // Output logic
  always @(state or w or clk) begin
    case (state)
      A: begin
        if (s == 1)
          state <= B;
        else
          state <= A;
      end
      B: begin
        if ((w == 1) && (w == #1 w == 1))
          z <= 1;
        else
          z <= 0;
        state <= A;
      end
    endcase
  end
endmodule
