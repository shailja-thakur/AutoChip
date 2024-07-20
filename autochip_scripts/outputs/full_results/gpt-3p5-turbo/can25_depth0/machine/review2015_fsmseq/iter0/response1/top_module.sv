module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

  // State declaration
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // initial state S
    else
      case (state)
        3'b000: // S
          if (data)
            state <= 3'b001; // S1
          else
            state <= 3'b000; // S
        3'b001: // S1
          if (data)
            state <= 3'b010; // S11
          else
            state <= 3'b000; // S
        3'b010: // S11
          if (data)
            state <= 3'b010; // S11
          else
            state <= 3'b011; // S110
        3'b011: // S110
          if (data)
            state <= 3'b100; // Done
          else
            state <= 3'b000; // S
        3'b100: // Done
          state <= 3'b100; // Done
      endcase
  end
  
  always @(posedge clk) begin
    start_shifting <= (state == 3'b100); // Output assignment
  end

endmodule
