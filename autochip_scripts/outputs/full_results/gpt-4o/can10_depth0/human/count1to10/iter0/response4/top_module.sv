module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // Reset the counter to 1
        end
        else begin
            if (q == 4'b1010) begin 
                q <= 4'b0001;  // If the counter is 10, wrap around to 1
            end
            else begin
                q <= q + 1;  // Otherwise, increment the counter
            end
        end
    end

endmodule
