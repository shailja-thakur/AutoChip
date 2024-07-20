module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
        COUNT1 = 2'b10,
        COUNT2 = 2'b11
	} state_t;
	
	state_t state, next_state;
    reg [1:0] w_count;  // Counter to check how many times 'w' has been 1 in 3 cycles

	// State and counter update logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
            w_count <= 0;
		end else begin
			state <= next_state;
            if (state == B) begin
                w_count <= (w_count + (w ? 1 : 0));
            end else begin
                w_count <= 0;
            end
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (s) next_state = B;
				else next_state = A;
			end
			B: begin
                if (w_count == 3) next_state = A; // Go back to A after 3 w cycles
                else next_state = B;
			end
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 0;
		end else begin
            if (state == B && w_count == 3) begin
                z <= (w_count == 2);
            end else begin
                z <= 0;
            end
		end
	end

endmodule
