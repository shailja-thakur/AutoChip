module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg [2:0] count;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter BYTE_RECEIVED = 3'b100;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		count <= 3'b0;
		data <= 8'b0;
		done <= 1'b0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					count <= 3'b0;
					data <= 8'b0;
					done <= 1'b0;
				end
			end
			START_BIT: begin
				if (count == 3'b0) begin
					if (in == 1'b0) begin
						count <= count + 1'b1;
					end else begin
						state <= IDLE;
					end
				end else begin
					state <= DATA_BITS;
				end
			end
			DATA_BITS: begin
				if (count < 3'b8) begin
					if (in == 1'b0) begin
						count <= count + 1'b1;
					end else begin
						state <= IDLE;
					end
				end else begin
					state <= STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b0) begin
					data <= data << 1;
				end else begin
					state <= IDLE;
				end
			end
			BYTE_RECEIVED: begin
				state <= IDLE;
				done <= 1'b1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == DATA_BITS) begin
		data <= {data[6:0], in};
	end else if (state == STOP_BIT) begin
		if (in == 1'b1) begin
			state <= BYTE_RECEIVED;
		end else begin
			state <= IDLE;
		end
	end
end

endmodule
