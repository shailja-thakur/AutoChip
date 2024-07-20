module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= 0;
            for (int i = 1; i < 511; i = i + 1) begin
                if (q[i-1] == 1 && q[i] == 1 && q[i+1] == 1)
                    q[i] <= 0;
                else if (q[i-1] == 1 && q[i] == 1 && q[i+1] == 0)
                    q[i] <= 1;
                else if (q[i-1] == 1 && q[i] == 0 && q[i+1] == 1)
                    q[i] <= 1;
                else if (q[i-1] == 1 && q[i] == 0 && q[i+1] == 0)
                    q[i] <= 0;
                else if (q[i-1] == 0 && q[i] == 1 && q[i+1] == 1)
                    q[i] <= 1;
                else if (q[i-1] == 0 && q[i] == 1 && q[i+1] == 0)
                    q[i] <= 1;
                else if (q[i-1] == 0 && q[i] == 0 && q[i+1] == 1)
                    q[i] <= 1;
                else if (q[i-1] == 0 && q[i] == 0 && q[i+1] == 0)
                    q[i] <= 0;
            end
            q[511] <= 0;
        end
    end
endmodule
