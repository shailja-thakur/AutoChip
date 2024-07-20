module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

  reg [3:0] d;
  reg [3:0] d_next;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      d <= 4'b0;
    end else begin
      d <= d_next;
    end
  end

  always @* begin
    if (!resetn) begin
      d_next = 4'b0;
    end else begin
      d_next = {d[2:0], in};
    end
  end

  assign out = d[3];

endmodule
