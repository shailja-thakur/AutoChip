module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

  reg [255:0] q_next;
  reg [255:0] q_tmp;
  reg [7:0] neighbours;
  
  always@(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 16; i = i + 1) begin
        neighbours[0] = q[i*16 + 15] + q[i*16 + 1];
        neighbours[1] = q[i*16 + 15] + q[i*16] + q[i*16 + 1];
        neighbours[2] = q[i*16] + q[i*16 + 1] + q[i*16 + 17];
        neighbours[3] = q[i*16 + 1] + q[i*16 + 17];
        neighbours[4] = q[i*16 + 1] + q[i*16 + 2] + q[i*16 + 17];
        neighbours[5] = q[i*16 + 1] + q[i*16 + 2] + q[i*16 + 16] + q[i*16 + 17];
        neighbours[6] = q[i*16 + 2] + q[i*16 + 16] + q[i*16 + 17];
        neighbours[7] = q[i*16 + 16] + q[i*16 + 17];
        
        for (int j = i*16; j < (i+1)*16; j = j + 1) begin
          case (neighbours)
            0: q_next[j] = 0;
            1: q_next[j] = 0;
            2: q_next[j] = q[j];
            3: q_next[j] = 1;
            default: q_next[j] = 0;
          endcase
        end
      end
      q_tmp = q_next;
      q_next = 0;
      q = q_tmp;
    end
  end
endmodule
