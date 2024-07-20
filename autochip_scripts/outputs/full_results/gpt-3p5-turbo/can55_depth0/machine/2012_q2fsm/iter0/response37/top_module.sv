module top_module (
  input clk,
  input reset,
  input w,
  output z
);

reg [2:0] state;
reg clk_edge;

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000; // Initial state is A
		clk_edge <= 1'b0;
	end else begin
		state <= clk_edge ? state : {w, state[2:1]}; // Update state based on w and current state
		clk_edge <= ~clk_edge;
	end
end

assign z = (state == 3'b100) || (state == 3'b101); // Set z to 1 when state is E or F

endmodule
