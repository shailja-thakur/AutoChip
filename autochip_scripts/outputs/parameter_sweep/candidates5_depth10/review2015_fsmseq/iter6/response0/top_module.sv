module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state; // added next_state variable

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end else begin
			state <= next_state; // updated state using next_state
		end
	end

	always @(state or data) begin
		next_state = state; // initialize next_state to current state

		case (state)
			0: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 1;
				end else begin
					next_state = 0;
				end
			end
			1: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 2;
				end else begin
					next_state = 0;
				end
			end
			2: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 3;
				end else begin
					next_state = 0;
				end
			end
			3: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 4;
				end else begin
					next_state = 0;
				end
			end
			4: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 5;
				end else begin
					next_state = 0;
				end
			end
			5: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 6;
				end else begin
					next_state = 0;
				end
			end
			6: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 7;
				end else begin
					next_state = 0;
				end
			end
			7: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 8;
				end else begin
					next_state = 0;
				end
			end
			8: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 9;
				end else begin
					next_state = 0;
				end
			end
			9: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 10;
				end else begin
					next_state = 0;
				end
			end
			10: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 11;
				end else begin
					next_state = 0;
				end
			end
			11: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 12;
				end else begin
					next_state = 0;
				end
			end
			12: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 13;
				end else begin
					next_state = 0;
				end
			end
			13: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 14;
				end else begin
					next_state = 0;
				end
			end
			14: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 15;
				end else begin
					next_state = 0;
				end
			end
			15: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 16;
				end else begin
					next_state = 0;
				end
			end
			16: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 17;
				end else begin
					next_state = 0;
				end
			end
			17: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 18;
				end else begin
					next_state = 0;
				end
			end
			18: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 19;
				end else begin
					next_state = 0;
				end
			end
			19: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 20;
				end else begin
					next_state = 0;
				end
			end
			20: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 21;
				end else begin
					next_state = 0;
				end
			end
			21: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 22;
				end else begin
					next_state = 0;
				end
			end
			22: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 23;
				end else begin
					next_state = 0;
				end
			end
			23: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 24;
				end else begin
					next_state = 0;
				end
			end
			24: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 25;
				end else begin
					next_state = 0;
				end
			end
			25: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 26;
				end else begin
					next_state = 0;
				end
			end
			26: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 27;
				end else begin
					next_state = 0;
				end
			end
			27: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 28;
				end else begin
					next_state = 0;
				end
			end
			28: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 29;
				end else begin
					next_state = 0;
				end
			end
			29: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 30;
				end else begin
					next_state = 0;
				end
			end
			30: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 31;
				end else begin
					next_state = 0;
				end
			end
			31: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 32;
				end else begin
					next_state = 0;
				end
			end
			32: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 33;
				end else begin
					next_state = 0;
				end
			end
			33: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 34;
				end else begin
					next_state = 0;
				end
			end
			34: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 35;
				end else begin
					next_state = 0;
				end
			end
			35: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 36;
				end else begin
					next_state = 0;
				end
			end
			36: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 37;
				end else begin
					next_state = 0;
				end
			end
			37: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 38;
				end else begin
					next_state = 0;
				end
			end
			38: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 39;
				end else begin
					next_state = 0;
				end
			end
			39: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 40;
				end else begin
					next_state = 0;
				end
			end
			40: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 41;
				end else begin
					next_state = 0;
				end
			end
			41: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 42;
				end else begin
					next_state = 0;
				end
			end
			42: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 43;
				end else begin
					next_state = 0;
				end
			end
			43: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 44;
				end else begin
					next_state = 0;
				end
			end
			44: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 45;
				end else begin
					next_state = 0;
				end
			end
			45: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 46;
				end else begin
					next_state = 0;
				end
			end
			46: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 47;
				end else begin
					next_state = 0;
				end
			end
			47: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 48;
				end else begin
					next_state = 0;
				end
			end
			48: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 49;
				end else begin
					next_state = 0;
				end
			end
			49: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 50;
				end else begin
					next_state = 0;
				end
			end
			50: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 51;
				end else begin
					next_state = 0;
				end
			end
			51: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 52;
				end else begin
					next_state = 0;
				end
			end
			52: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 53;
				end else begin
					next_state = 0;
				end
			end
			53: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 54;
				end else begin
					next_state = 0;
				end
			end
			54: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 55;
				end else begin
					next_state = 0;
				end
			end
			55: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 56;
				end else begin
					next_state = 0;
				end
			end
			56: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 57;
				end else begin
					next_state = 0;
				end
			end
			57: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 58;
				end else begin
					next_state = 0;
				end
			end
			58: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 59;
				end else begin
					next_state = 0;
				end
			end
			59: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 60;
				end else begin
					next_state = 0;
				end
			end
			60: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 61;
				end else begin
					next_state = 0;
				end
			end
			61: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 62;
				end else begin
					next_state = 0;
				end
			end
			62: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 63;
				end else begin
					next_state = 0;
				end
			end
			63: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 64;
				end else begin
					next_state = 0;
				end
			end
			64: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 65;
				end else begin
					next_state = 0;
				end
			end
			65: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 66;
				end else begin
					next_state = 0;
				end
			end
			66: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 67;
				end else begin
					next_state = 0;
				end
			end
			67: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 68;
				end else begin
					next_state = 0;
				end
			end
			68: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 69;
				end else begin
					next_state = 0;
				end
			end
			69: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 70;
				end else begin
					next_state = 0;
				end
			end
			70: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 71;
				end else begin
					next_state = 0;
				end
			end
			71: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 72;
				end else begin
					next_state = 0;
				end
			end
			72: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 73;
				end else begin
					next_state = 0;
				end
			end
			73: begin
				if (data == 1'b0) begin // changed "===" to "=="
					next_state = 74;
				end else begin
					next_state = 0;
				end
			end
			74: begin
				if (data == 1'b1) begin // changed "===" to "=="
					next_state = 75;
				end else begin
					next_state = 0;
				end
			end
			75: begin
				if (data == 1'b0) begin // changed "===" to "=="
					start_shifting <= 1;
					next_state = 0;
				end else begin
					next_state = 0;
				end
			end
		endcase
	end

endmodule
