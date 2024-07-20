module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);
  
  // Registers to store the temporary values of the cells
  reg [511:0] temp_q;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      // Handle left boundary
      if (q[511] && q[510] && q[509])
        temp_q[511] <= 0;
      else if (q[511] && q[510] && ~q[509])
        temp_q[511] <= 1;
      else if (q[511] && ~q[510] && q[509])
        temp_q[511] <= 1;
      else if (q[511] && ~q[510] && ~q[509])
        temp_q[511] <= 0;
      else if (~q[511] && q[510] && q[509])
        temp_q[511] <= 1;
      else if (~q[511] && q[510] && ~q[509])
        temp_q[511] <= 1;
      else if (~q[511] && ~q[510] && q[509])
        temp_q[511] <= 1;
      else if (~q[511] && ~q[510] && ~q[509])
        temp_q[511] <= 0;
      
      // Handle center cells
      for (int i = 510; i > 0; i = i - 1) begin
        if (q[i-1] && q[i] && q[i+1])
          temp_q[i] <= 0;
        else if (q[i-1] && q[i] && ~q[i+1])
          temp_q[i] <= 1;
        else if (q[i-1] && ~q[i] && q[i+1])
          temp_q[i] <= 1;
        else if (q[i-1] && ~q[i] && ~q[i+1])
          temp_q[i] <= 0;
        else if (~q[i-1] && q[i] && q[i+1])
          temp_q[i] <= 1;
        else if (~q[i-1] && q[i] && ~q[i+1])
          temp_q[i] <= 1;
        else if (~q[i-1] && ~q[i] && q[i+1])
          temp_q[i] <= 1;
        else if (~q[i-1] && ~q[i] && ~q[i+1])
          temp_q[i] <= 0;
      end
      
      // Handle right boundary
      if (q[1] && q[0] && q[511])
        temp_q[0] <= 0;
      else if (q[1] && q[0] && ~q[511])
        temp_q[0] <= 1;
      else if (q[1] && ~q[0] && q[511])
        temp_q[0] <= 1;
      else if (q[1] && ~q[0] && ~q[511])
        temp_q[0] <= 0;
      else if (~q[1] && q[0] && q[511])
        temp_q[0] <= 1;
      else if (~q[1] && q[0] && ~q[511])
        temp_q[0] <= 1;
      else if (~q[1] && ~q[0] && q[511])
        temp_q[0] <= 1;
      else if (~q[1] && ~q[0] && ~q[511])
        temp_q[0] <= 0;
      
      q <= temp_q;
    end
  end
  
endmodule
