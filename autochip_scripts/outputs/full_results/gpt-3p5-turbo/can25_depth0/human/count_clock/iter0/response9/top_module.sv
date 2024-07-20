module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

reg [7:0] sec_count;
reg [7:0] min_count;
reg [7:0] hour_count;

always @(posedge clk) begin
	if (reset) begin
		pm <= 0;
		hh <= 8'b0001; // Reset to 12 AM
		mm <= 8'b0000;
		ss <= 8'b0000;
		sec_count <= 8'b0000;
		min_count <= 8'b0000;
		hour_count <= 8'b0001;
	end else if (ena) begin
		sec_count <= sec_count + 1;
		if (sec_count == 8'b0110) begin // If seconds reached 60
			sec_count <= 8'b0000;
			min_count <= min_count + 1;
			if (min_count == 8'b1100) begin // If minutes reached 60
				min_count <= 8'b0000;
				hour_count <= hour_count + 1;
				if (hour_count == 8'b1100) begin // If hours reached 13
					hour_count <= 8'b0001;
					pm <= ~pm; // Toggle AM/PM indicator
				end
			end
		end
	end
end

always @(posedge clk) begin
	if (reset) begin
		hh <= 8'b0001; // Reset to 12 AM
		mm <= 8'b0000;
		ss <= 8'b0000;
	end else begin
		hh[3:0] <= hour_count[3:0];
		hh[7:4] <= hour_count[7:4];
		mm[3:0] <= min_count[3:0];
		mm[7:4] <= min_count[7:4];
		ss[3:0] <= sec_count[3:0];
		ss[7:4] <= sec_count[7:4];
	end
end

endmodule
