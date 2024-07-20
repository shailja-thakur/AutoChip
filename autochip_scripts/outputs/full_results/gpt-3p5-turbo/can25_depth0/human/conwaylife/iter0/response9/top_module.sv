module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

reg [255:0] q_next;

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    q <= q_next;
  end
end

integer i, j, count;

always @* begin
  for (i = 0; i < 16; i = i + 1) begin
    for (j = 0; j < 16; j = j + 1) begin
      count = 0;
      
      // Top-left neighbor
      if (q[((i + 15) & 15) * 16 + ((j + 15) & 15)]) begin
        count = count + 1;
      end
      
      // Top neighbor
      if (q[((i + 15) & 15) * 16 + j]) begin
        count = count + 1;
      end
      
      // Top-right neighbor
      if (q[((i + 15) & 15) * 16 + ((j + 1) & 15)]) begin
        count = count + 1;
      end
      
      // Left neighbor
      if (q[i * 16 + ((j + 15) & 15)]) begin
        count = count + 1;
      end
      
      // Right neighbor
      if (q[i * 16 + ((j + 1) & 15)]) begin
        count = count + 1;
      end
      
      // Bottom-left neighbor
      if (q[((i + 1) & 15) * 16 + ((j + 15) & 15)]) begin
        count = count + 1;
      end
      
      // Bottom neighbor
      if (q[((i + 1) & 15) * 16 + j]) begin
        count = count + 1;
      end
      
      // Bottom-right neighbor
      if (q[((i + 1) & 15) * 16 + ((j + 1) & 15)]) begin
        count = count + 1;
      end
      
      // Update cell state
      if (count <= 1) begin
        q_next[i * 16 + j] = 0;
      end else if (count == 2) begin
        q_next[i * 16 + j] = q[i * 16 + j];
      end else if (count == 3) begin
        q_next[i * 16 + j] = 1;
      end else begin
        q_next[i * 16 + j] = 0;
      end
    end
  end
end

endmodule
