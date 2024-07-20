module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [15:0] q_next;
  reg [3:1] ena_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
      ena_reg <= 0;
    end else begin
      q <= q_next;
      ena_reg <= ena;
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_next <= 0;
    end else begin
      q_next[3:0] <= q[3:0];
      q_next[7:4] <= q[7:4];
      q_next[11:8] <= q[11:8];
      q_next[15:12] <= q[15:12];
      
      if (ena_reg[1]) begin
        q_next[3:0] <= q_next[3:0] + 1;
      end
      
      if (ena_reg[2]) begin
        q_next[7:4] <= q_next[7:4] + 1;
      end
      
      if (ena_reg[3]) begin
        q_next[11:8] <= q_next[11:8] + 1;
      end
      
      if (ena_reg[3]) begin
        q_next[15:12] <= q_next[15:12] + 1;
      end
    end
  end
  
  assign ena = q[7:1];
  
endmodule
