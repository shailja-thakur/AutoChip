module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100;  // When 'a' is 1, output is fixed at 4
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000;  // Reset to 0 when q reaches 6
            end else begin
                q <= q + 3'b001;  // Increment q
            end
        end
    end
endmodule
