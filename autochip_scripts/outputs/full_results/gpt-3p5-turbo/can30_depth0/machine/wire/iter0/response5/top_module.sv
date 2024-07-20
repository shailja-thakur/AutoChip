module top_module(
	input wire clk,
	input wire reset,
	output wire data_out,
	output wire valid_out);

	reg [1:0] state;
	reg [3:0] counter;

	// internal signals
	reg [3:0] data_out_internal;

	// assign outputs
	assign data_out = data_out_internal;
	assign valid_out = (state == 3'b011);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001; // idle state
			counter <= 4'd0;
			data_out_internal <= 4'd0;
		end else begin
			case (state)
				3'b001: begin // idle state
					counter <= 4'd0;
					data_out_internal <= 4'd0;
					if (in) begin
						state <= 3'b010; // wait state
					end
				end
				3'b010: begin // wait state
					counter <= counter + 4'd1;
					data_out_internal <= 4'd0;
					if (counter >= 4'd5) begin
						state <= 3'b011; // process state
						data_out_internal <= in;
					end
				end
				3'b011: begin // process state
					state <= 3'b100; // done state
				end
				3'b100: begin // done state
					state <= 3'b001; // idle state
					data_out_internal <= 4'd0;
				end
			endcase
		end
	end

endmodule
