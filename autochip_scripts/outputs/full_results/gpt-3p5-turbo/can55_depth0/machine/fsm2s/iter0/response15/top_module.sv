module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg State, Next_State;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		State <= 0;
	end else begin
		State <= Next_State;
	end
end

always @* begin
	if (State == 0) begin
		if (j) begin
			Next_State = 1;
		end else begin
			Next_State = 0;
		end
	end else begin
		if (k) begin
			Next_State = 0;
		end else begin
			Next_State = 1;
		end
	end
end

assign out = (State == 1);

endmodule
