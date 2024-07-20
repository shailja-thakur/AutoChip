module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);
  
  reg [255:0] q_temp; // temporary variable to store the updated state of the game
  
  // combinational logic to update the state of the game
  always @(*) begin
    for (integer i = 0; i < 256; i = i + 1) begin
      integer row = i / 16;
      integer col = i % 16;
      
      integer count = 0;
      
      // count the number of alive neighbors
      if (q[((row - 1 + 16) % 16) * 16 + ((col - 1 + 16) % 16)] == 1)
        count = count + 1;
      if (q[((row - 1 + 16) % 16) * 16 + col] == 1)
        count = count + 1;
      if (q[((row - 1 + 16) % 16) * 16 + ((col + 1) % 16)] == 1)
        count = count + 1;
      if (q[row * 16 + ((col - 1 + 16) % 16)] == 1)
        count = count + 1;
      if (q[row * 16 + ((col + 1) % 16)] == 1)
        count = count + 1;
      if (q[((row + 1) % 16) * 16 + ((col - 1 + 16) % 16)] == 1)
        count = count + 1;
      if (q[((row + 1) % 16) * 16 + col] == 1)
        count = count + 1;
      if (q[((row + 1) % 16) * 16 + ((col + 1) % 16)] == 1)
        count = count + 1;
      
      // update the state of the cell based on the number of neighbors
      if (count == 2)
        q_temp[i] = q[i];
      else if (count == 3)
        q_temp[i] = 1;
      else
        q_temp[i] = 0;
    end
  end
  
  // sequential logic to update the game state every clock cycle
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q_temp;
    end
  end
  
endmodule
