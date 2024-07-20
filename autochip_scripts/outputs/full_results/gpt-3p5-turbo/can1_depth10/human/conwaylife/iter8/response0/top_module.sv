module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [15:0] qGrid [15:0];
  reg [15:0] nextGrid [15:0];

  always @(posedge clk) begin
    if (load) begin
      for (integer row = 0; row < 16; row = row + 1)
        qGrid[row] <= data[(row*16)+:16];
    end
  end

  always @(posedge clk) begin
    for (integer row = 0; row < 16; row = row + 1) begin
      for (integer col = 0; col < 16; col = col + 1) begin
        integer neighbors = 0;

        if (qGrid[(row-1+16)%16][col]) neighbors = neighbors + 1; // Top
        if (qGrid[row][(col+1)%16]) neighbors = neighbors + 1; // Right
        if (qGrid[(row+1)%16][col]) neighbors = neighbors + 1; // Bottom
        if (qGrid[row][(col-1+16)%16]) neighbors = neighbors + 1; // Left
        if (qGrid[(row-1+16)%16][(col+1)%16]) neighbors = neighbors + 1; // Top-Right
        if (qGrid[(row+1)%16][(col+1)%16]) neighbors = neighbors + 1; // Bottom-Right
        if (qGrid[(row+1)%16][(col-1+16)%16]) neighbors = neighbors + 1; // Bottom-Left
        if (qGrid[(row-1+16)%16][(col-1+16)%16]) neighbors = neighbors + 1; // Top-Left

        if (neighbors <= 1) begin // Rule 1
          nextGrid[row][col] <= 1'b0;
        end else if (neighbors == 2) begin // Rule 2
          nextGrid[row][col] <= qGrid[row][col];
        end else if (neighbors == 3) begin // Rule 3
          nextGrid[row][col] <= 1'b1;
        end else begin // Rule 4
          nextGrid[row][col] <= 1'b0;
        end
      end
    end

    for (integer row = 0; row < 16; row = row + 1) begin
      qGrid[row] <= nextGrid[row];
    end
  end

  always_comb begin
    for (integer row = 0; row < 16; row = row + 1) begin
      q[(row*16)+:16] = qGrid[row];
    end
  end

endmodule
