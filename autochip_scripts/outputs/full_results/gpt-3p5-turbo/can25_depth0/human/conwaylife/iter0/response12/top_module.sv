module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [7:0] neighbors [0:255];
  reg [7:0] state [0:255];
  reg [7:0] new_state [0:255];
  
  always @(posedge clk) begin
    if (load) begin
      for (int i = 0; i < 256; i = i + 1) begin
        q[i] <= data[i];
        state[i] <= data[i];
      end
    end else begin
      for (int i = 0; i < 256; i = i + 1) begin
        neighbors[i] = 0;
        
        // Calculate the number of neighbors
        if (i % 16 != 0) begin
          neighbors[i] = neighbors[i] + state[i - 1];
          neighbors[i - 1] = neighbors[i - 1] + state[i];
        end else begin
          neighbors[i] = neighbors[i] + state[i + 15];
          neighbors[i + 15] = neighbors[i + 15] + state[i];
        end
        
        if (i % 16 != 15) begin
          neighbors[i] = neighbors[i] + state[i + 1];
          neighbors[i + 1] = neighbors[i + 1] + state[i];
        end else begin
          neighbors[i] = neighbors[i] + state[i - 15];
          neighbors[i - 15] = neighbors[i - 15] + state[i];
        end
        
        if (i > 15) begin
          neighbors[i] = neighbors[i] + state[i - 16];
          neighbors[i - 16] = neighbors[i - 16] + state[i];
        end else begin
          neighbors[i] = neighbors[i] + state[i + 240];
          neighbors[i + 240] = neighbors[i + 240] + state[i];
        end
        
        if (i < 240) begin
          neighbors[i] = neighbors[i] + state[i + 16];
          neighbors[i + 16] = neighbors[i + 16] + state[i];
        end else begin
          neighbors[i] = neighbors[i] + state[i - 240];
          neighbors[i - 240] = neighbors[i - 240] + state[i];
        end
        
        // Update cell state based on the number of neighbors
        if (neighbors[i] <= 1) begin
          new_state[i] = 0;
        end else if (neighbors[i] == 2) begin
          new_state[i] = state[i];
        end else if (neighbors[i] == 3) begin
          new_state[i] = 1;
        end else begin
          new_state[i] = 0;
        end
      end
      
      // Update q with the new state
      for (int i = 0; i < 256; i = i + 1) begin
        q[i] <= new_state[i]; 
        state[i] <= new_state[i];
      end
    end
  end
endmodule
