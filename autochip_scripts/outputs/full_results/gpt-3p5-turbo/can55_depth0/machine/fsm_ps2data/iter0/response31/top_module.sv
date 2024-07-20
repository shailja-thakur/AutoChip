module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] out_bytes_reg;
wire [2:0] next_state;

// Output assignment
assign out_bytes = out_bytes_reg;
assign done = (state == 3'b011);

// State transition and output updates on rising edge of clock
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b00;
		out_bytes_reg <= 24'b0;
	end else begin
		state <= next_state;
		if (state == 3'b100) begin
			out_bytes_reg <= in;
		end else if (state == 3'b011) begin
			out_bytes_reg <= out_bytes_reg << 8;
		end
	end
end

// Next state and output logic
always @* begin
	case(state)
		3'b000: begin
			if (in[2]) begin
				next_state = 3'b001;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b001: begin
			next_state = 3'b010;
		end
		3'b010: begin
			next_state = 3'b011;
		end
		3'b011: begin
			if (in[2]) begin
				next_state = 3'b100;
			end else begin
				next_state = 3'b000;
			end
		end
		3'b100: begin
			next_state = 3'b000;
		end
		default: begin
			next_state = 3'b000;
		end
	endcase
end

endmodule
