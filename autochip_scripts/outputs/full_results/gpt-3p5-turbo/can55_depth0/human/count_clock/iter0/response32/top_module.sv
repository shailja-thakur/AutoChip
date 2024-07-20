module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Create intermediate variables for each counter
	reg [7:0] hh_count;
	reg [7:0] mm_count;
	reg [7:0] ss_count;

	// Create 6-bit counters for each BCD digit
	reg [5:0] hh_digit1;
	reg [5:0] hh_digit2;
	reg [5:0] mm_digit1;
	reg [5:0] mm_digit2;
	reg [5:0] ss_digit1;
	reg [5:0] ss_digit2;

	// Internal signals for clock logic
	reg [2:0] pm_next;
	reg [5:0] hh_digit1_next;
	reg [5:0] hh_digit2_next;
	reg [5:0] mm_digit1_next;
	reg [5:0] mm_digit2_next;
	reg [5:0] ss_digit1_next;
	reg [5:0] ss_digit2_next;

	// Asynchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all counters to 0
			hh_count <= 0;
			mm_count <= 0;
			ss_count <= 0;

			hh_digit1 <= 6'b0;
			hh_digit2 <= 6'b0;
			mm_digit1 <= 6'b0;
			mm_digit2 <= 6'b0;
			ss_digit1 <= 6'b0;
			ss_digit2 <= 6'b0;
		end else begin
			// Update counters on rising edge of clk and when enabled
			if (ena) begin
				hh_count <= hh_count + 1;
				mm_count <= mm_count + 1;
				ss_count <= ss_count + 1;
			end

			// Convert counters to BCD digits
			hh_digit1 <= hh_count[3:0];
			hh_digit2 <= hh_count[7:4];
			mm_digit1 <= mm_count[3:0];
			mm_digit2 <= mm_count[7:4];
			ss_digit1 <= ss_count[3:0];
			ss_digit2 <= ss_count[7:4];
		end
	end

	// Synchronous assignments on rising edge of clk
	always @(posedge clk) begin
		pm <= pm_next;
		hh <= {hh_digit2, hh_digit1};
		mm <= {mm_digit2, mm_digit1};
		ss <= {ss_digit2, ss_digit1};
	end

	// PM signal logic
	always @* begin
		if (hh_count >= 12) begin
			pm_next = 1'b1;
		end else begin
			pm_next = 1'b0;
		end
	end

endmodule
