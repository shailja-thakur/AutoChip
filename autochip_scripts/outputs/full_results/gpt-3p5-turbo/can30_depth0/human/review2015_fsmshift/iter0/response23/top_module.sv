module top_module(
	input clk,
	input reset,
	output shift_ena);

	// Internal signal declaration
	reg [3:0] count;
	reg shift_ena_reg;
	reg shift_ena_next;

	// FSM states
	localparam IDLE = 0;
	localparam DETECT_PATTERN = 1;

	// FSM current state
	reg [1:0] state;

	// Combinational logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			shift_ena_reg <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					if (<<YOUR CONDITION HERE>>) begin
						shift_ena_reg <= 1'b1;
						count <= 4'b1111;
						state <= DETECT_PATTERN;
					end else begin
						shift_ena_reg <= 1'b0;
						count <= 0;
						state <= IDLE;
					end
				end
				DETECT_PATTERN: begin
					if (count == 0) begin
						shift_ena_reg <= 1'b0;
						count <= 0;
						state <= IDLE;
					end else begin
						shift_ena_reg <= 1'b1;
						count <= count - 1;
						state <= DETECT_PATTERN;
					end
				end
			endcase
		end
	end
	
	// Sequential logic
	always @(posedge clk) begin
		shift_ena_next <= shift_ena_reg;
	end

	// Output assignment
	assign shift_ena = shift_ena_next;

endmodule
