module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// internal signals
reg [7:0] count;
reg [7:0] input_reg;
reg [7:0] output_reg;
reg reset_counter;

// Moore state machine states
parameter IDLE = 0;
parameter CONVERT = 1;

// state register
reg [1:0] state;

// state transition always block
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
	end else begin
		case (state)
			IDLE:
				if (x == 1'b0) begin
					state <= CONVERT;
					reset_counter <= 1;
				end else begin
					state <= IDLE;
				end
			CONVERT:
				if (reset_counter == 8) begin
					state <= IDLE;
				end else begin
					state <= CONVERT;
				end
		endcase
	end
end

// state output always block
always @(state) begin
	case (state)
		IDLE:
			z <= 1'b0;
		CONVERT:
			z <= ~input_reg;
	endcase
end

// synchronous reset counter
always @(posedge clk or posedge areset) begin
	if (areset) begin
		reset_counter <= 0;
	end else begin
		if (state == CONVERT) begin
			reset_counter <= reset_counter + 1;
		end
	end
end

// input register
always @(posedge clk or posedge areset) begin
	if (areset) begin
		input_reg <= 0;
	end else begin
		if (state == CONVERT) begin
			input_reg <= {input_reg[6:0], x};
		end
	end
end

// output register
always @(posedge clk or posedge areset) begin
	if (areset) begin
		output_reg <= 0;
	end else begin
		if (state == CONVERT) begin
			output_reg <= {output_reg[6:0], ~x};
		end
	end
end

// counter for sign extension
always @(posedge clk or posedge areset) begin
	if (areset) begin
		count <= 0;
	end else begin
		if (state == CONVERT) begin
			count <= count + 1;
		end
	end
end

endmodule
