module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load)
      next_q <= data;
    else begin
      for (integer i = 0; i < 256; i = i + 1) begin
        integer alive_count = 0;
        
        if (i >= 16) begin
          if (q[i-16])
            alive_count = alive_count + 1;
        end else begin
          if (q[i+240])
            alive_count = alive_count + 1;
        end
        
        if (i < 240) begin
          if (q[i+16])
            alive_count = alive_count + 1;
        end else begin
          if (q[i-240])
            alive_count = alive_count + 1;
        end
        
        if (i % 16 > 0) begin
          if (q[i-1])
            alive_count = alive_count + 1;
        end else begin
          if (q[i+15])
            alive_count = alive_count + 1;
        end
        
        if (i % 16 < 15) begin
          if (q[i+1])
            alive_count = alive_count + 1;
        end else begin
          if (q[i-15])
            alive_count = alive_count + 1;
        end
        
        if (alive_count == 2)
          next_q[i] = q[i];
        else if (alive_count == 3)
          next_q[i] = 1;
        else
          next_q[i] = 0;
      end
    end
  end

  always @(posedge clk) begin
    q <= next_q;
  end

endmodule
