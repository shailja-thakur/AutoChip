module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 256; i = i + 1) begin
        reg [2:0] count;
        count = 0;
        if (i / 16 > 0) begin
          if (q[i-16]) begin
            count = count + 1;
          end
        end else begin
          if (q[i+240]) begin
            count = count + 1;
          end
        end
        if (i % 16 > 0) begin
          if (q[i-1]) begin
            count = count + 1;
          end
        end else begin
          if (q[i+15]) begin
            count = count + 1;
          end
        end
        if (i % 16 < 15) begin
          if (q[i+1]) begin
            count = count + 1;
          end
        end else begin
          if (q[i-15]) begin
            count = count + 1;
          end
        end
        if (i / 16 < 15) begin
          if (q[i+16]) begin
            count = count + 1;
          end
        end else begin
          if (q[i-240]) begin
            count = count + 1;
          end
        end
        
        if (count == 0 || count == 1 || count >= 4) begin
          next_q[i] = 0;
        end else if (count == 3) begin
          next_q[i] = 1;
        end else begin
          next_q[i] = q[i];
        end
      end
      q <= next_q;
    end
  end
endmodule
