module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] q_next;

  always @(posedge clk) begin
    if (load == 1'b1) begin
      q <= data;
    end else begin
      q <= q_next;
    end
  end

  always @* begin
    q_next = q;
    for (integer i=0; i<256; i=i+1) begin
      integer row = i / 16;
      integer col = i % 16;

      integer left_col = (col == 0) ? 15 : col-1;
      integer right_col = (col == 15) ? 0 : col+1;
      integer up_row = (row == 0) ? 15 : row-1;
      integer down_row = (row == 15) ? 0 : row+1;

      integer num_neighbors = q[up_row*16+left_col] + q[up_row*16+col] + q[up_row*16+right_col]
                             + q[row*16+left_col] + q[row*16+right_col]
                             + q[down_row*16+left_col] + q[down_row*16+col] + q[down_row*16+right_col];

      if (num_neighbors == 0 || num_neighbors == 1 || num_neighbors >= 4) begin
        q_next[i] = 1'b0;
      end else if (num_neighbors == 3) begin
        q_next[i] = 1'b1;
      end
    end
  end

endmodule
