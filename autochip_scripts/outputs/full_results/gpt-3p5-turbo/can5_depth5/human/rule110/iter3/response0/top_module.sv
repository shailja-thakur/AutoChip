module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      reg [511:0] q_next;
      
      for (integer i = 0; i < 512; i = i + 1) begin
        if (i == 0) begin // Handle boundary condition at q[-1]
          q_next[0] = (~q[0] & (q[1] | data[0]));
        end else if (i == 511) begin // Handle boundary condition at q[512]
          q_next[511] = (~q[511] & (data[510] | q[510]));
        end else begin // Apply Rule 110 to all other cells
          q_next[i] = (~q[i] & ((q[i-1] | q[i+1]) & ~(data[i-1] & data[i+1])));
        end
      end
      
      q <= q_next;
    end
  end
endmodule
