module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;
always @(posedge clk) begin
  if (reset == 1'b1)
    state <= B;
  else begin
    if (state == A) begin
      if (in == 1'b1)
        state <= A;
      else
        state <= B;
    end else begin
      if (in == 1'b1)
        state <= B;
      else
        state <= A;
    end
  end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
