module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss
);

	reg [3:0] hours = 4'd1;
	reg [5:0] minutes = 6'd0;
	reg [5:0] seconds = 6'd0;
	reg [1:0] tens_of_hours = 2'd0;
	reg [3:0] ones_of_hours = 4'd0;
	reg [3:0] tens_of_minutes = 4'd0;
	reg [3:0] ones_of_minutes = 4'd0;
	reg [3:0] tens_of_seconds = 4'd0;
	reg [3:0] ones_of_seconds = 4'd0;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hours <= 4'd1;
			minutes <= 6'd0;
			seconds <= 6'd0;
			tens_of_hours <= 2'd0;
			ones_of_hours <= 4'd0;
			tens_of_minutes <= 4'd0;
			ones_of_minutes <= 4'd0;
			tens_of_seconds <= 4'd0;
			ones_of_seconds <= 4'd0;
			pm <= 1'b0;
		end else if (ena) begin
			if (seconds == 6'd59) begin
				seconds <= 6'd0;
				if (minutes == 6'd59) begin
					minutes <= 6'd0;
					if (hours == 4'd11) begin
						hours <= 4'd0;
						pm <= ~pm;
					end else begin
						hours <= hours + 1;
						if (hours == 4'd10) begin
							hours <= 4'd1;
							tens_of_hours <= tens_of_hours + 1;
							if (tens_of_hours == 2'd1 && ones_of_hours == 4'd9) begin
								tens_of_hours <= 2'd0;
								ones_of_hours <= 4'd0;
							end else begin
								ones_of_hours <= ones_of_hours + 1;
							end
						end else begin
							if (ones_of_hours == 4'd9) begin
								ones_of_hours <= 4'd0;
							end else begin
								ones_of_hours <= ones_of_hours + 1;
							end
						end
					end
				end else begin
					if (tens_of_minutes == 4'd5 && ones_of_minutes == 4'd9) begin
						minutes <= 6'd0;
						tens_of_minutes <= 4'd0;
						ones_of_minutes <= 4'd0;
					end else begin
						seconds <= seconds + 1;
						if (seconds == 4'd10) begin
							seconds <= 4'd0;
							tens_of_seconds <= tens_of_seconds + 1;
							if (tens_of_seconds == 4'd6 && ones_of_seconds == 4'd9) begin
								tens_of_seconds <= 4'd0;
								ones_of_seconds <= 4'd0;
								minutes <= minutes + 1;
								if (minutes == 4'd10) begin
									minutes <= 4'd0;
									tens_of_minutes <= tens_of_minutes + 1;
									if (tens_of_minutes == 4'd6 && ones_of_minutes == 4'd9) begin
										minutes <= 6'd0;
										tens_of_minutes <= 4'd0;
										ones_of_minutes <= 4'd0;
										hours <= hours + 1;
										if (hours == 4'd10) begin
											hours <= 4'd1;
											tens_of_hours <= tens_of_hours + 1;
											if (tens_of_hours == 2'd1 && ones_of_hours == 4'd9) begin
												tens_of_hours <= 2'd0;
												ones_of_hours <= 4'd0;
											end else begin
												ones_of_hours <= ones_of_hours + 1;
											end
										end else begin
											if (ones_of_hours == 4'd9) begin
												ones_of_hours <= 4'd0;
											end else begin
												ones_of_hours <= ones_of_hours + 1;
											end
										end
									end else begin
										if (ones_of_minutes == 4'd9) begin
											ones_of_minutes <= 4'd0;
										end else begin
											ones_of_minutes <= ones_of_minutes + 1;
										end
									end
								end else begin
									if (ones_of_minutes == 4'd9) begin
										ones_of_minutes <= 4'd0;
									end else begin
										ones_of_minutes <= ones_of_minutes + 1;
									end
								end
							end else begin
								if (ones_of_seconds == 4'd9) begin
									ones_of_seconds <= 4'd0;
									minutes <= minutes + 1;
									if (minutes == 4'd10) begin
										minutes <= 4'd0;
										tens_of_minutes <= tens_of_minutes + 1;
										if (tens_of_minutes == 4'd6 && ones_of_minutes == 4'd9) begin
											minutes <= 6'd0;
											tens_of_minutes <= 4'd0;
											ones_of_minutes <= 4'd0;
											hours <= hours + 1;
											if (hours == 4'd10) begin
												hours <= 4'd1;
												tens_of_hours <= tens_of_hours + 1;
												if (tens_of_hours == 2'd1 && ones_of_hours == 4'd9) begin
													tens_of_hours <= 2'd0;
													ones_of_hours <= 4'd0;
												end else begin
													ones_of_hours <= ones_of_hours + 1;
												end
											end else begin
												if (ones_of_hours == 4'd9) begin
													ones_of_hours <= 4'd0;
												end else begin
													ones_of_hours <= ones_of_hours + 1;
												end
											end
										end else begin
											if (ones_of_minutes == 4'd9) begin
												ones_of_minutes <= 4'd0;
											end else begin
												ones_of_minutes <= ones_of_minutes + 1;
											end
										end
									end else begin
										if (ones_of_minutes == 4'd9) begin
											ones_of_minutes <= 4'd0;
										end else begin
											ones_of_minutes <= ones_of_minutes + 1;
										end
									end
								end else begin
									ones_of_seconds <= ones_of_seconds + 1;
								end
							end
						end else begin
							ones_of_seconds <= ones_of_seconds + 1;
						end
					end
				end
			end else begin
				seconds <= seconds + 1;
			end
		end
	end

	always @(hours) begin
		case (hours)
			4'd0: hh = {tens_of_hours, ones_of_hours};
			default: hh = {ones_of_hours, tens_of_hours};
		endcase
	end

	always @(minutes) begin
		case (minutes)
			6'd0: mm = {tens_of_minutes, ones_of_minutes};
			default: mm = {ones_of_minutes, tens_of_minutes};
		endcase
	end

	always @(seconds) begin
		case (seconds)
			6'd0: ss = {tens_of_seconds, ones_of_seconds};
			default: ss = {ones_of_seconds, tens_of_seconds};
		endcase
	end

endmodule
