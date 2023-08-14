module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

	// Insert your code below
	
    bcdcount counter0 (clk, reset, c_enable[0], Q0);
    bcdcount counter1 (clk, reset, c_enable[1], Q1);

	always @(posedge clk) begin
		if (Q0 == 9) begin
			c_enable[0] <= 1;
		end else begin
			c_enable[0] <= 0;
		end

		if (Q1 == 9) begin
			c_enable[1] <= 1;
		end else begin
			c_enable[1] <= 0;
		end

		if (Q0 == 0 && Q1 == 0) begin
			OneHertz <= 1;
		end else begin
			OneHertz <= 0;
		end
	end

endmodule