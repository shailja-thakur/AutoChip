module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // set state to A
		end else begin
			state <= next_state; // set state to next_state
		end
	end

	always @* begin
		case (state)
			2'b00: begin // state A
				if (r[1]) begin // if r[1] is high
					next_state = 2'b01; // set next_state to B
				end else if (r[2]) begin // if r[2] is high
					next_state = 2'b10; // set next_state to C
				end else if (r[3]) begin // if r[3] is high
					next_state = 2'b11; // set next_state to D
				end else begin // if none of the bits of r are high
					next_state = 2'b00; // set next_state to A
				end
			end
			2'b01: begin // state B
				if (r[1]) begin // if r[1] is high
					next_state = 2'b01; // set next_state to B
				end else begin // if r[1] is low
					next_state = 2'b00; // set next_state to A
				end
			end
			2'b10: begin // state C
				if (r[2]) begin // if r[2] is high
					next_state = 2'b10; // set next_state to C
				end else begin // if r[2] is low
					next_state = 2'b00; // set next_state to A
				end
			end
			2'b11: begin // state D
				if (r[3]) begin // if r[3] is high
					next_state = 2'b11; // set next_state to D
				end else begin // if r[3] is low
					next_state = 2'b00; // set next_state to A
				end
			end
		endcase
	end

	assign g[1] = (state == 2'b01); // set g[1] high if current state is B
	assign g[2] = (state == 2'b10); // set g[2] high if current state is C
	assign g[3] = (state == 2'b11); // set g[3] high if current state is D
endmodule
