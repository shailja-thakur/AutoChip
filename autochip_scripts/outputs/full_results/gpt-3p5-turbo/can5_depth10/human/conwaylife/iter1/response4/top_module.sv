module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
  
  reg [255:0] q_next;
  reg [7:0] neighbours;
  
  always@(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 16; i = i + 1) begin
        for (int j = 0; j < 16; j = j + 1) begin
          neighbours = q[((i+15)%16)*16 + ((j+15)%16)] + q[((i+15)%16)*16 + j] + q[((i+15)%16)*16 + ((j+1)%16)] +
                       q[i*16 + ((j+15)%16)] + q[i*16 + ((j+1)%16)] +
                       q[((i+1)%16)*16 + ((j+15)%16)] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + ((j+1)%16)];
          case (neighbours)
            0, 1: q_next[i*16 + j] = 0;
            2: q_next[i*16 + j] = q[i*16 + j];
            3: q_next[i*16 + j] = 1;
            default: q_next[i*16 + j] = 0;
          endcase
        end
      end
      q <= q_next;
    end
  end
endmodule
