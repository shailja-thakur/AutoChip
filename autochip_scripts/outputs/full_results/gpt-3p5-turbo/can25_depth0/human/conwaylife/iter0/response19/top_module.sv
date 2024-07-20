module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end

  generate
    genvar i;
    for (i = 0; i < 16; i = i + 1) begin
      genvar j;
      for (j = 0; j < 16; j = j + 1) begin
        integer neighbors;
        always @(q) begin
          neighbors = q[i*16 + (j+1)%16] + q[i*16 + (j+15)%16] + q[((i+1)%16)*16 + j] + q[((i+15)%16)*16 + j] +
                      q[((i+1)%16)*16 + (j+1)%16] + q[((i+1)%16)*16 + (j+15)%16] + q[((i+15)%16)*16 + (j+1)%16] + q[((i+15)%16)*16 + (j+15)%16];
        end

        always @(posedge clk) begin
          if (neighbors <= 1 || neighbors >= 4) begin
            next_q[i*16 + j] <= 0;
          end else if (neighbors == 3) begin
            next_q[i*16 + j] <= 1;
          end else begin
            next_q[i*16 + j] <= q[i*16 + j];
          end
        end
      end
    end
  endgenerate

endmodule
