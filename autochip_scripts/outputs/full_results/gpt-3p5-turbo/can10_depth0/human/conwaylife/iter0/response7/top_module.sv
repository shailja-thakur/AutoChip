module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      next_q = q;

      // Iterate through each cell in the grid
      for (int i = 0; i < 256; i = i + 1) begin
        // Determine the coordinates of the current cell
        int x = i % 16;
        int y = i / 16;

        int count = 0;

        // Check each of the 8 neighbors of the current cell
        for (int dx = -1; dx <= 1; dx = dx + 1) begin
          for (int dy = -1; dy <= 1; dy = dy + 1) begin
            if ((dx != 0 || dy != 0) && q[((y + dy + 16) % 16) * 16 + ((x + dx + 16) % 16)] == 1) begin
              count = count + 1;
            end
          end
        end

        // Determine the next state of the current cell based on the number of neighbors
        if (count == 2) begin
          next_q[i] = q[i];
        end else if (count == 3) begin
          next_q[i] = 1;
        end else begin
          next_q[i] = 0;
        end
      end

      q <= next_q;
    end
  end
endmodule
