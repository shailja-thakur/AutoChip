module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	typedef enum reg [2:0] {
		IDLE,
		START,
		DATA,
		STOP,
		ERROR
	} state_t;
	
	state_t state, next_state;
	reg [7:0] data;
	reg [3:0] bit_count;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data <= 8'd0;
			bit_count <= 4'd0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (state == DATA && bit_count < 8) begin
				data[bit_count] <= in; // store data bits
			end
		end
	end

	always @(*) begin
		next_state = state;
		done = 1'b0;
		case (state)
			IDLE: begin
				if (in == 1'b0) begin // Start bit detected
					next_state = START;
				end
			end
			START: begin
				next_state = DATA;
				bit_count = 4'd0;
			end
			DATA: begin
				if (bit_count < 8) begin
					next_state = DATA;
					bit_count = bit_count + 1;
				end else begin
					next_state = STOP;
				end
			end
			STOP: begin
				if (in == 1'b1) begin // Stop bit detected
					out_byte = data;
					done = 1'b1;
					next_state = IDLE;
				end else begin // Invalid stop bit
					next_state = ERROR;
				end
			end
			ERROR: begin
				if (in == 1'b1) begin // Wait for line to return to idle
					next_state = IDLE;
				end
			end
		endcase
	end
endmodule
