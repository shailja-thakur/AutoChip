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

// Generate q_next based on q
always @* begin
  for (int i = 0; i < 256; i = i + 1) begin
    int count = 0;
    
    // Calculate the number of alive neighbors
    count = count + q[(i-16+256) % 256];
    count = count + q[(i+16) % 256];
    count = count + q[(i-1+256) % 256];
    count = count + q[(i+1) % 256];
    count = count + q[(i-17+256) % 256];
    count = count + q[(i-15+256) % 256];
    count = count + q[(i+15) % 256];
    count = count + q[(i+17) % 256];
    
    if (count <= 1 || count >= 4) begin
      q_next[i] = 0;
    end else if (count == 3) begin
      q_next[i] = 1;
    end else begin
      q_next[i] = q[i];
    end
  end
end

endmodule
