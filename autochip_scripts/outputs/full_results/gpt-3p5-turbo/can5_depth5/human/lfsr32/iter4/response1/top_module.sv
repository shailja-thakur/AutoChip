module top_module(
  input wire clk,
  input wire reset,
  output reg [31:0] q);

  reg [31:0] q_next;

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= q_next;
    end
  end

  always @* begin
    if (reset) begin
      q_next = 32'h1;
    end else begin
      q_next = {q[30:0], q[20]^q[0]^q[1]^q[31]};
    end
  end

endmodule
