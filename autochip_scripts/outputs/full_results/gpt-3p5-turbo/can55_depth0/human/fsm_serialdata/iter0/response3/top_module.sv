module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [8:0] bit_counter;
reg [7:0] data_byte;
reg start_bit_found;
reg stop_bit_found;
reg [7:0] received_data_byte;
reg byte_received;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		bit_counter <= 9'b0;
		data_byte <= 8'b0;
		start_bit_found <= 1'b0;
		stop_bit_found <= 1'b0;
		received_data_byte <= 8'b0;
		byte_received <= 1'b0;
	end else begin
		if (start_bit_found && !stop_bit_found) begin
			bit_counter <= bit_counter + 1'b1;
			data_byte <= {data_byte[6:0], in};
			if (bit_counter == 8'b111) begin
				stop_bit_found <= 1'b1;
				received_data_byte <= data_byte;
			end
		end else begin
			bit_counter <= 1'b0;
			data_byte <= 8'b0;
			if (!start_bit_found && in == 1'b0) begin
				start_bit_found <= 1'b1;
			end else if (start_bit_found && in == 1'b1) begin
				start_bit_found <= 1'b0;
			end
		end
	end
end

always @(posedge clk) begin
	if (reset) begin
		byte_received <= 1'b0;
	end else begin
		if (stop_bit_found) begin
			byte_received <= 1'b1;
		end else begin
			byte_received <= 1'b0;
		end
	end
end

assign out_byte = received_data_byte;
assign done = byte_received;

endmodule
