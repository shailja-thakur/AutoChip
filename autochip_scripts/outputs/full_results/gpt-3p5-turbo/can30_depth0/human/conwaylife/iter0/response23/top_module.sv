module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);
  
  reg [255:0] q_next;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q_next;
    end
  end

  // Helper function to calculate the number of alive neighbors for a given cell
  function integer count_neighbors;
    input [255:0] grid;
    input integer cell_idx;
    integer count;
    begin
      count = grid[cell_idx - 17] + grid[cell_idx - 16] + grid[cell_idx - 15] + grid[cell_idx - 1]
              + grid[cell_idx + 1] + grid[cell_idx + 15] + grid[cell_idx + 16] + grid[cell_idx + 17];
    end
  endfunction

  // Combinational logic to calculate the next state of each cell
  generate
    genvar i;
    for (i = 0; i < 256; i = i + 1) begin : CELL_UPDATE_LOOP
      always_comb begin
        integer alive_neighbors = count_neighbors(q, i);
        if (alive_neighbors <= 1) begin
          q_next[i] = 0;
        end else if (alive_neighbors == 2) begin
          q_next[i] = q[i];
        end else if (alive_neighbors == 3) begin
          q_next[i] = 1;
        end else begin
          q_next[i] = 0;
        end
      end
    end
  endgenerate

endmodule
