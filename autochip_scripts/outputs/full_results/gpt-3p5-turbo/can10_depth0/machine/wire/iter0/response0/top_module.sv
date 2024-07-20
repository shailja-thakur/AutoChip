module top_module(
	input wire clk,
	input wire rst,
	output wire data_out,
	output wire valid_out);

	// internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// FSM states
	localparam IDLE_STATE = 2'b00;
	localparam WAIT_STATE = 2'b01;
	localparam PROCESS_STATE = 2'b10;
	localparam DONE_STATE = 2'b11;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE_STATE;
			counter <= 8'd0;
			data <= 8'd0;
		end else begin
			case (state)
				IDLE_STATE: begin
					counter <= 8'd0;
					data <= 8'd0;
					if (in) begin
						state <= WAIT_STATE;
					end
				end
				
				WAIT_STATE: begin
					counter <= counter + 8'd1;
					data <= 8'd0;
					if (counter >= 8'hFF) begin
						state <= PROCESS_STATE;
					end
				end
				
				PROCESS_STATE: begin
					data <= in;
					state <= DONE_STATE;
				end
				
				DONE_STATE: begin
					data <= in;
					state <= IDLE_STATE;
				end
			endcase
		end
	end

	assign out = data;
	assign valid_out = (state == DONE_STATE);

endmodule
