module top_module(
	input clk,
	input reset,
	output shift_ena);

	parameter B0 = 3'b000;
	parameter B1 = 3'b001;
	parameter B2 = 3'b010;
	parameter B3 = 3'b011;
	parameter Done = 3'b100;
	
	reg [2:0] state;
	reg shift_ena;

	always @(posedge clk) begin
		if (reset) begin
			state <= B0;
		end else if (state == B0) begin
			state <= B1;
		end else if (state == B1) begin
			state <= B2;
		end else if (state == B2) begin
			state <= B3;
		end else if (state == B3) begin
			state <= Done;
		end else begin
			state <= Done;
		end
	end

	always @(state, reset) begin
		if (reset) begin
			shift_ena <= 1'b0;
		end else begin
			shift_ena <= (state == B0 || state == B1 || state == B2 || state == B3) ? 1'b1 : 1'b0;
		end
	end

endmodule
