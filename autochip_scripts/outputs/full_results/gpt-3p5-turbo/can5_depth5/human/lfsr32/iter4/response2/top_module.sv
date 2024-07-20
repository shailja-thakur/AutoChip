module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_next <= 32'h1;
    end else begin
      q_next <= {q[31:1], q[21]^q[1]^q[0]};
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      q <= q_next;
    end else begin
      q <= q_next;
    end
  end

endmodule
