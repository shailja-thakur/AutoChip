module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'd0; // reset counter to 0
        end else begin
            if (q == 10'd999) begin
                q <= 10'd0; // reset counter to 0 after reaching 999
            end else begin
                q <= q + 10'd1; // increment counter
            end
        end
    end

endmodule
