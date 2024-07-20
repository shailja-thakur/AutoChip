module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] q_next;
  wire [255:0] q_next_delayed;

  // Assigning q_next_delayed
  always @(posedge clk) begin
    q_next <= q_next_delayed;
  end

  // Implementing the Game of Life rules
  always @(q_next_delayed or data) begin
    for (integer i=0; i<256; i=i+16) begin
      integer row = i;
      integer next_row = i+16;
      integer prev_row = i-16;

      for (integer j=0; j<16; j=j+1) begin
        integer col = j;
        integer next_col = j+1;
        integer prev_col = j-1;

        // Wrap around the toroid edges
        if (j == 0) begin
          next_col = 1;
          prev_col = 15;
        end
        else if (j == 15) begin
          next_col = 0;
          prev_col = 14;
        end

        // Counting the number of neighbors for each cell
        integer neighbors = q_next_delayed[next_row+prev_col] + q_next_delayed[next_row+col] +
                            q_next_delayed[next_row+next_col] + q_next_delayed[row+prev_col] +
                            q_next_delayed[row+next_col] + q_next_delayed[prev_row+prev_col] +
                            q_next_delayed[prev_row+col] + q_next_delayed[prev_row+next_col];

        // Updating the cell state based on the Game of Life rules
        if (neighbors <= 1) begin
          q_next_delayed[row+col] = 0;
        end
        else if (neighbors == 3) begin
          q_next_delayed[row+col] = 1;
        end
        else if (neighbors >= 4) begin
          q_next_delayed[row+col] = 0;
        end
      end
    end
  end

  // Loading initial state
  always @(posedge clk) begin
    if (load) begin
      q_next_delayed <= data;
    end
    else begin
      q_next_delayed <= q_next;
    end
  end

  // Updating q at the positive edge of the clock
  always @(posedge clk) begin
    q <= q_next;
  end

endmodule
