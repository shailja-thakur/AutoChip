module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q;
  integer i, j;
  integer count;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      next_q = q;
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          count = q[(i+1)*16+j] + q[(i-1)*16+j] + q[i*16+(j+1)] + q[i*16+(j-1)] + q[(i+1)*16+(j+1)] + q[(i-1)*16+(j+1)] + q[(i+1)*16+(j-1)] + q[(i-1)*16+(j-1)];
          if (q[i*16+j] == 0 && (count == 3)) begin
            next_q[i*16+j] = 1;
          end else if (q[i*16+j] == 1 && (count < 2 || count > 3)) begin
            next_q[i*16+j] = 0;
          end else begin
            next_q[i*16+j] = q[i*16+j];
          end
        end
      end
      q <= next_q;
    end
  end

endmodule
