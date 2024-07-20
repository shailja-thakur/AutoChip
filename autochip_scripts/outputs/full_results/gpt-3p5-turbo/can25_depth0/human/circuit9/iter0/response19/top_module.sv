module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
// Define a flip flop
reg [2:0] q_next;

// Create a flip flop using always @(posedge clk)
always @(posedge clk) begin
    if (a == 1'b1) begin
        q_next <= 4'b010; // Output q becomes 4 when a is high
    end
    else begin
        q_next <= q; // Output q remains the same when a is low
    end
end

// Assign the next value of q to the current value of q
always @(posedge clk) begin
    q <= q_next;
end

endmodule
