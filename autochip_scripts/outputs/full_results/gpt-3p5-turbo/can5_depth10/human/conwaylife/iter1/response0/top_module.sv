module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
  
  reg [255:0] q_next;
  reg [15:0] neighbours;
  
  always@(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 16; i = i + 1) begin
        for (int j = 0; j < 16; j = j + 1) begin
          neighbours = q[(i+15)%16*16 + (j+15)%16] + 
                      q[(i+15)%16*16 + j] + 
                      q[(i+15)%16*16 + (j+1)%16] + 
                      q[i*16 + (j+15)%16] + 
                      q[i*16 + (j+1)%16] + 
                      q[(i+1)%16*16 + (j+15)%16] + 
                      q[(i+1)%16*16 + j] + 
                      q[(i+1)%16*16 + (j+1)%16];
          if (q[i*16 + j] == 1 && !(neighbours == 2 || neighbours == 3)) begin
            q_next[i*16 + j] = 0;
          end else if (q[i*16 + j] == 0 && neighbours == 3) begin
            q_next[i*16 + j] = 1;
          end else begin
            q_next[i*16 + j] = q[i*16 + j];
          end
        end
      end
      q <= q_next;
    end
  end
endmodule
