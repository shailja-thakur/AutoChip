module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q, state; // declaring q and state as registers

always @(posedge clk) begin
	if (state == 0) begin // if state is 0
		if (a == 0 && b == 0) begin // if a and b are 0
			state = 0; // set state to 0
			q = 0; // set q to 0
		end else if (a == 0 && b == 1) begin // if a is 0 and b is 1
			state = 1; // set state to 1
			q = 1; // set q to 1
		end else if (a == 1 && b == 0) begin // if a is 1 and b is 0
			state = 0; // set state to 1
			q = 1; // set q to 1
		end else begin // default case
			state = 0; // set state to 1
			q = 0; // set q to 0
		end
	end else if (state == 1) begin // if state is 1
		if (a == 1 && b == 1) begin // if a and b are 1
			state = 1; // set state to 1
			q = 1; // set q to 1
		end else if (a == 1 && b == 0) begin // if a is 1 and b is 0
			state = 0; // set state to 0
			q = 0; // set q to 0
		end else begin // default case
			state = 1; // set state to 1
			q = 1; // set q to 1
		end
	end
end

endmodule
