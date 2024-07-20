module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

  reg [7:0] q_temp;  // intermediate register for q

  always @(posedge clk) begin
    if (reset) begin
      q_temp <= 8'b0;  // reset q_temp to zero
    end else begin
      q_temp <= d;  // assign input d to q_temp
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q <= 8'b0;  // reset q to zero
    end else begin
      q <= q_temp;  // assign q_temp to output q
    end
  end

endmodule
