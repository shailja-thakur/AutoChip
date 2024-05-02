module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  always @(posedge clk) begin
    if (load) begin
      q <= data; 
    end
    else begin
      reg [255:0] q_next;
      
      // Compute next state
      for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) begin
          int num_neighbours = 0;
          
          // Check wraparound 
          if (i == 0) begin
            num_neighbours += q[255] + q[241] + q[240];
          end
          else if (i == 15) begin
            num_neighbours += q[15] + q[0] + q[1];  
          end
          else begin
            num_neighbours += q[i*16-1] + q[(i+1)*16-1];
          end
            
          if (j == 0) begin
            num_neighbours += q[i*16+15] + q[i*16+14] + q[i*16+13];  
          end
          else if (j == 15) begin
            num_neighbours += q[i*16] + q[i*16+1] + q[i*16+2];
          end
          else begin
            num_neighbours += q[i*16+j-1] + q[i*16+j+1];  
          end
          
          // Apply rules
          if (q[i*16+j] == 1) begin
            if (num_neighbours < 2 || num_neighbours > 3)
              q_next[i*16+j] = 0;
            else
              q_next[i*16+j] = 1;
          end
          else begin
            if (num_neighbours == 3)
              q_next[i*16+j] = 1;
            else
              q_next[i*16+j] = 0;
          end
        end
      end
      
      q <= q_next;
    end
  end

endmodule