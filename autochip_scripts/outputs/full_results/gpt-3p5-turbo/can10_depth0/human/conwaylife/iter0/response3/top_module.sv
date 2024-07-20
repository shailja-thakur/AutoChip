module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q;
  reg [7:0] neighbours_cnt;
  reg [7:0] i, j;

  // Logic for calculating neighbours count
  always @*
  begin
    // Iterate through each cell
    for (i = 0; i < 16; i = i + 1)
    begin
      for (j = 0; j < 16; j = j + 1)
      begin
        neighbours_cnt = 0;

        // Calculate neighbours count for cell (i, j)
        if (q[i*16 + ((j+1)%16)] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[i*16 + ((j-1+16)%16)] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[((i+1)%16)*16 + j] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[((i-1+16)%16)*16 + j] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[((i+1)%16)*16 + ((j+1)%16)] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[((i-1+16)%16)*16 + ((j+1)%16)] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[((i+1)%16)*16 + ((j-1+16)%16)] == 1) neighbours_cnt = neighbours_cnt + 1;
        if (q[((i-1+16)%16)*16 + ((j-1+16)%16)] == 1) neighbours_cnt = neighbours_cnt + 1;

        // Apply game rules and update next_q
        if (neighbours_cnt <= 1)
          next_q[i*16 + j] = 0;
        else if (neighbours_cnt == 2)
          next_q[i*16 + j] = q[i*16 + j];
        else if (neighbours_cnt == 3)
          next_q[i*16 + j] = 1;
        else if (neighbours_cnt >= 4)
          next_q[i*16 + j] = 0;
      end
    end
  end

  // Assign next_q to q at every positive edge of clk
  always @(posedge clk)
  begin
    if (load)
      q <= data;
    else
      q <= next_q;
  end

endmodule
