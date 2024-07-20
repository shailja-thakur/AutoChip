module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// State enumeration
	typedef enum logic [1:0] {
		IDLE,
		CONVERT
	} state_e;

	// Define register variables
	reg [1:0] current_state;
	reg [3:0] count;
	reg signed [31:0] input_value;
	reg signed [31:0] output_value;

	// Define wires
	wire signed [31:0] input_value_positive;
	wire signed [31:0] two_complement;

	// Sequential logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= IDLE;
			count <= 0;
			input_value <= 0;
			output_value <= 0;
		end else begin
			case (current_state)
				IDLE: begin
					if (areset || x) begin
						current_state <= IDLE;
						count <= 0;
						input_value <= 0;
						output_value <= 0;
					end else begin
						current_state <= CONVERT;
						count <= 0;
						input_value <= 0;
						output_value <= 0;
					end
				end
				CONVERT: begin
					if (count == 31) begin
						current_state <= IDLE;
						output_value <= -input_value;
					end else begin
						current_state <= CONVERT;
						count <= count + 1;
						input_value <= {x, input_value_positive[30:0]};
					end
				end
				default: begin
					current_state <= IDLE;
					count <= 0;
					input_value <= 0;
					output_value <= 0;
				end
			endcase
		end
	end

	// Dataflow logic
	assign input_value_positive = (x) ? (32'b0 - input_value) : input_value;
	assign two_complement = -input_value_positive;
	assign z = (current_state == CONVERT) ? two_complement[31] : 1'b0;

endmodule
