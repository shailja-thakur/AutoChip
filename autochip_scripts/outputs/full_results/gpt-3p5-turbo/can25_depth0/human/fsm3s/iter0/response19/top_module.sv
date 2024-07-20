module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Declare FSM states
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;
	
	// Declare state and next_state variables
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Declare output variable
	wire output;

	// Define state transition table
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Define next state and output logic
	always @(state, in) begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
					out = 0;
				end else begin
					next_state = A;
					out = 0;
				end
			end
			
			B: begin
				if (in) begin
					next_state = B;
					out = 0;
				end else begin
					next_state = C;
					out = 0;
				end
			end
			
			C: begin
				if (in) begin
					next_state = D;
					out = 0;
				end else begin
					next_state = A;
					out = 0;
				end
			end
			
			D: begin
				if (in) begin
					next_state = B;
					out = 1;
				end else begin
					next_state = C;
					out = 1;
				end
			end
			
			default: begin
				next_state = A;
				out = 0;
			end
		endcase
	end
	
	// Assign output to the module output
	assign out = output;

endmodule
