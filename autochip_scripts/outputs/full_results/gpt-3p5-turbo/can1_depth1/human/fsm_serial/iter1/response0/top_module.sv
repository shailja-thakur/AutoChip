module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg start_detected;
reg [7:0] data;
reg stop_detected;

// Define states
enum [2:0] {IDLE, START_BIT, DATA_BITS, STOP_BIT} state, next_state;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= IDLE;
		start_detected <= 0;
		data <= 0;
		stop_detected <= 0;
	end
	else begin
		state <= next_state;
		start_detected <= start_detected;
		data <= data;
		stop_detected <= stop_detected;
	end
end

always @(state or in) begin
	// Default assignments
	next_state = state;
	start_detected = start_detected; 
	data = data;
	stop_detected = stop_detected;

	case(state)
		IDLE: begin
			if(in == 1'b0) begin
				next_state = START_BIT;
			end
		end

		START_BIT: begin
			if(in == 1'b0) begin
				next_state = DATA_BITS;
				data[0] <= 1'b0;
			end
		end

		DATA_BITS: begin
			if(in == 1'b1) begin
				data[7:1] <= data[6:0];
				data[0] <= 1'b0;

				if(data[7] == 1'b1) begin
					next_state = STOP_BIT;
				end
			end
		end

		STOP_BIT: begin
			if(in == 1'b1) begin
				next_state = IDLE;
				stop_detected <= 1'b1;
			end
		end
	endcase
end

assign done = stop_detected;

endmodule
