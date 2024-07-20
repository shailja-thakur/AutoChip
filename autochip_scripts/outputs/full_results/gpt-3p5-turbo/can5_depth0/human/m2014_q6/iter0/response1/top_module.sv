module top_module (
	input clk,
	input reset,
	input w,
	output z
);


reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset)begin
	if (reset) begin
		state <= 0;
	end else begin
		state <= next_state;
	end
end

always @(state or w) begin
	case(state)
		0: begin // A
			if(w) begin
				next_state = 0;
			end else begin
				next_state = 1;
			end
		end
		1: begin // B
			if(w) begin
				next_state = 3;
			end else begin
				next_state = 2;
			end
		end
		2: begin // C
			if(w) begin
				next_state = 4;
			end else begin
				next_state = 3;
			end
		end
		3: begin // D
			if(w) begin
				next_state = 1;
			end else begin
				next_state = 5;
			end
		end
		4: begin // E
			if(w) begin
				next_state = 5;
			end else begin
				next_state = 3;
			end
		end
		5: begin // F
			if(w) begin
				next_state = 2;
			end else begin
				next_state = 3;
			end
		end
		default: begin
			next_state = 0;
		end
	endcase
end

always @(state) begin
	case(state)
		4, 5: begin
			z = 1;
		end
		default: begin
			z = 0;
		end
	endcase
end

endmodule
