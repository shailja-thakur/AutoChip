module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 4;  // Set q to 4 when a is 1
        end else begin
            if (q == 6) begin
                q <= 0;  // Reset q to 0 when it reaches 6
            end else begin
                q <= q + 1;  // Increment q by 1 when a is 0
            end
        end
    end
endmodule
