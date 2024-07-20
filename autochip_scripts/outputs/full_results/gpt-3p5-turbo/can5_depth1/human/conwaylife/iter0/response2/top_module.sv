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

  generate
    genvar i, j;
    for (i = 0; i < 16; i = i + 1) begin : ROW
      for (j = 0; j < 16; j = j + 1) begin : COLUMN
        localparam left = (j == 0) ? 15 : (j - 1);
        localparam right = (j == 15) ? 0 : (j + 1);
        localparam top = (i == 0) ? 15 : (i - 1);
        localparam bottom = (i == 15) ? 0 : (i + 1);
        reg [7:0] neighbors;

        always @* begin
          // Calculate the number of neighbors
          neighbors = q[top*16 + left] +
                      q[top*16 + j] +
                      q[top*16 + right] +
                      q[i*16 + left] +
                      q[i*16 + right] +
                      q[bottom*16 + left] +
                      q[bottom*16 + j] +
                      q[bottom*16 + right];
        end

        always @(posedge clk) begin
          if (load) begin
            // No change during load
            q_next[i*16 + j] <= q[i*16 + j];
          else begin
            if (neighbors == 1'b0 || neighbors > 3'b11) begin
              // Cell becomes 0
              q_next[i*16 + j] <= 1'b0;
            end else if (neighbors == 3'b11) begin
              // Cell becomes 1
              q_next[i*16 + j] <= 1'b1;
            end else begin
              // Cell state does not change
              q_next[i*16 + j] <= q[i*16 + j];
            end
          end
        end
      end
    end
  endgenerate

endmodule
