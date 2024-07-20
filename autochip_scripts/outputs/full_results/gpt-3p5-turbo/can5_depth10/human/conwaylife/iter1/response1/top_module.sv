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
          if (i == 0 && j == 0) begin
            neighbours[0] = q[255] + q[1] + q[240] + q[241] + q[16] + q[17] + q[15] + q[31];
          end else if (i == 0 && j == 15) begin
            neighbours[0] = q[254] + q[0] + q[239] + q[238] + q[30] + q[31] + q[14] + q[29];
          end else if (i == 15 && j == 0) begin
            neighbours[0] = q[240] + q[255] + q[16] + q[17] + q[0] + q[1] + q[224] + q[240];
          end else if (i == 15 && j == 15) begin
            neighbours[0] = q[239] + q[254] + q[31] + q[30] + q[223] + q[224] + q[238] + q[254];
          end else if (i == 0) begin
            neighbours[0] = q[j-1] + q[j+1] + q[j+14] + q[j+15] + q[j+16] + q[j+17] + q[j] + q[j+31];
          end else if (j == 0) begin
            neighbours[0] = q[(i-1)*16] + q[i*16+1] + q[i*16+15] + q[i*16+16] + q[i*16+17] + q[(i-1)*16] + q[i*16+14] + q[i*16+31];
          end else if (i == 15) begin
            neighbours[0] = q[j-1] + q[j+1] + q[j-2] + q[j-1] + q[j] + q[j+1] + q[j+16] + q[j+15];
          end else if (j == 15) begin
            neighbours[0] = q[(i-1)*16+15] + q[i*16] + q[(i-1)*16+14] + q[(i-1)*16+15] + q[i*16+14] + q[i*16+15] + q[(i+1)*16+15] + q[(i+1)*16+14];
          end else begin
            neighbours[0] = q[(i-1)*16+j-1] + q[(i-1)*16+j] + q[(i-1)*16+j+1] + q[i*16+j-1] + q[i*16+j+1] + q[(i+1)*16+j-1] + q[(i+1)*16+j] + q[(i+1)*16+j+1];
          end
          case (neighbours)
            0, 1: q_next[i*16+j] = 0;
            2: q_next[i*16+j] = q[i*16+j];
            3: q_next[i*16+j] = 1;
            default: q_next[i*16+j] = 0;
          endcase
        end
      end
      q <= q_next;
    end
  end
endmodule
