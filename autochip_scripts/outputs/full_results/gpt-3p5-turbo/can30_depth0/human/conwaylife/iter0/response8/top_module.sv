module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  // Internal wires
  wire [255:0] next_q;

  // Register to synchronize the load signal
  reg load_reg;
  always @(posedge clk) begin
    load_reg <= load;
  end

  // Assign the next state of q based on the current state and inputs
  always @(*) begin
    if (load_reg) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end

  // Calculate the next state of q based on the current state
  // and the rules of the game
  // Note: This implementation assumes a toroid grid

  // Helper function to count the number of neighbors for a given cell
  function integer count_neighbors;
    input [255:0] grid;
    input integer row;
    input integer column;
    reg [3:0] count;
    begin
      count = 0;
      count = count + grid[(row-1)*16 + (column-1)];
      count = count + grid[(row-1)*16 + column];
      count = count + grid[(row-1)*16 + (column+1)];
      count = count + grid[row*16 + (column-1)];
      count = count + grid[row*16 + (column+1)];
      count = count + grid[(row+1)*16 + (column-1)];
      count = count + grid[(row+1)*16 + column];
      count = count + grid[(row+1)*16 + (column+1)];
      return count;
    end
  endfunction

  // Calculate the next state of q based on the rules of the game
  // for each cell
  generate
    genvar row, column;
    for (row = 0; row < 16; row=row+1) begin : ROW_GEN
      for (column = 0; column < 16; column=column+1) begin : COLUMN_GEN
        always @(*) begin
          next_q[row*16 + column] = count_neighbors(q, row, column);
        end
      end
    end
  endgenerate

  // Update the state of q every clock cycle
  always @(posedge clk) begin
    if (!load_reg) begin
      q <= next_q;
    end
  end

endmodule
