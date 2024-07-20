module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
	
	// Define internal signal for state transition
	reg [4:0] q_next;
	
	// State transition always block triggered by q changes
	always @(q) begin
		q_next[4:1] = q[4:1]; // Assign q_next with q[4:1]
		q_next[4] = q[0]; // Assign q_next[4] with q[0]
		q_next[2] = q[2] ^ q[0]; // XOR q[2] with q[0]
	end
	
	// State assignment always block triggered at positive edge of clk
	always @(posedge clk) begin
		if (reset) begin // If reset is active
			q <= 5'h1; // Assign q with 5'h1
		end else begin // If reset is inactive
			q <= q_next; // Assign q with q_next
		end
	end

endmodule
