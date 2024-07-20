module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always@(posedge clk) begin
    if (load)
      q <= data;
    else begin
      q[511] <= 0;
      for (int i = 511; i > 0; i = i-1) begin
        if (q[i-1] == 1 && q[i] == 1 && q[i+1] == 1)
          q[i] <= 0;
        else if (q[i-1] == 1 && q[i] == 1 && q[i+1] == 0)
          q[i] <= 1;
        else if (q[i-1] == 1 && q[i] == 0 && q[i+1] == 1)
          q[i] <= 1;
        else if (q[i-1] == 1 && q[i] == 0 && q[i+1] == 0)
          q[i] <= 0;
        else if (q[i-1] == 0 && q[i] == 1 && q[i+1] == 1)
          q[i] <= 1;
        else if (q[i-1] == 0 && q[i] == 1 && q[i+1] == 0)
          q[i] <= 1;
        else if (q[i-1] == 0 && q[i] == 0 && q[i+1] == 1)
          q[i] <= 1;
        else if (q[i-1] == 0 && q[i] == 0 && q[i+1] == 0)
          q[i] <= 0;
      end
      q[0] <= 0;
    end
  end

endmodule
