module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

// Intermediate signal declaration
reg [4:0] q_next;

always @(*) begin
    // Assign q_next with state transition logic
    q_next = {q[0], q[4:1]};
    q_next[2] = q_next[2] ^ q[0];
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Assign reset value to q
        q <= 5'h1;
    end else begin
        // Assign q_next value to q on rising edge of clock
        q <= q_next;
    end
end

endmodule
