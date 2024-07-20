module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);
  
  reg [3:1] d;
  reg [3:1] ena_temp;
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 0;
      ena_temp <= 0;
    end
    else begin
      ena_temp <= d;
      if (ena_temp[1])
        q[3:0] <= q[3:0] + 1;
      if (ena_temp[2])
        q[7:4] <= q[7:4] + 1;
      if (ena_temp[3])
        q[11:8] <= q[11:8] + 1;
    end
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      d <= 0;
    else
      d <= {ena[2], ena[1], ena[3]};
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ena[1] <= 0;
      ena[2] <= 0;
      ena[3] <= 0;
    end
    else begin
      ena[1] <= ena_temp[1] || (reset && d[1]);
      ena[2] <= ena_temp[2] || (reset && d[2]);
      ena[3] <= ena_temp[3] || (reset && d[3]);
    end
  end
  
endmodule
