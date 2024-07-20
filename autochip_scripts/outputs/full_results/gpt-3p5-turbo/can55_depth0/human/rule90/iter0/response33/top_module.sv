module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

  // Create a 512-cell system
  reg [511:0] q_next;
  integer idx;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q_next;
    end
  end
  
  always @* begin
    for (idx = 0; idx < 512; idx = idx + 1) begin
      if (idx == 0) begin
        // Handle left-most boundary
        if (q[1] == 1) begin
          q_next[idx] = ~q[idx];
        end else begin
          q_next[idx] = q[idx];
        end
      end else if (idx == 511) begin
        // Handle right-most boundary
        if (q[510] == 1) begin
          q_next[idx] = ~q[idx];
        end else begin
          q_next[idx] = q[idx];
        end
      end else begin
        // All other cells
        if ((q[idx-1] == 1) && (q[idx+1] == 1)) begin
          q_next[idx] = 0;
        end else if ((q[idx-1] == 1) && (q[idx+1] == 0)) begin
          q_next[idx] = 1;
        end else if ((q[idx-1] == 0) && (q[idx+1] == 1)) begin
          q_next[idx] = 0;
        end else if ((q[idx-1] == 0) && (q[idx+1] == 0)) begin
          q_next[idx] = 1;
        end
      end
    end
  end
  
endmodule
