module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

    // Create a wire to store the next state of q
    reg [511:0] next_q;
    
	integer i;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;  // Load new data into q when load is high
		end 
        else begin
			// Compute the next state for each cell
			for (i = 0; i < 512; i = i + 1) begin
				case ({q[i+1], q[i], q[i-1]}) 
					3'b111: next_q[i] = 1'b0;
					3'b110: next_q[i] = 1'b1;
					3'b101: next_q[i] = 1'b1;
					3'b100: next_q[i] = 1'b0;
					3'b011: next_q[i] = 1'b1;
					3'b010: next_q[i] = 1'b1;
					3'b001: next_q[i] = 1'b1;
					3'b000: next_q[i] = 1'b0;
					default: next_q[i] = 1'b0; // Default case should not happen
				endcase
			end
			
			q <= next_q; // Update q with the computed next state
		end
	end

endmodule
