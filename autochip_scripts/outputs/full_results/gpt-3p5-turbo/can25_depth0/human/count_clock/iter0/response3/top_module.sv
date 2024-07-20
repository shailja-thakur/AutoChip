module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Create internal signals
	reg [7:0] hh_count;
	reg [7:0] mm_count;
	reg [7:0] ss_count;
	
	// Create intermediate signals for BCD conversion
	reg [3:0] hh_binary;
	reg [5:0] mm_binary;
	reg [5:0] ss_binary;
	reg [1:0] tens_binary;
	reg [3:0] ones_binary;
	
	// Reset logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hh_count <= 8'd1;
			mm_count <= 8'd0;
			ss_count <= 8'd0;
			pm <= 1'b0;
		end else begin
			// Clock enable logic
			if (ena) begin
				if (ss_count == 8'd59) begin
					ss_count <= 8'd0;
					
					if (mm_count == 8'd59) begin
						mm_count <= 8'd0;
						
						if (hh_count == 8'd11) begin
							hh_count <= 8'd1;
							
							// Toggle AM/PM indicator
							pm <= ~pm;
						end else begin
							hh_count <= hh_count + 8'd1;
						end
					end else begin
						mm_count <= mm_count + 8'd1;
					end
				end else begin
					ss_count <= ss_count + 8'd1;
				end
			end
		end
	end
	
	// BCD conversion logic
	always @(posedge clk) begin
		hh_binary <= hh_count;
		mm_binary <= mm_count;
		ss_binary <= ss_count;
		
		// Convert tens digit of hours from binary to BCD
		case(hh_binary[7:4])
			4'b0000: tens_binary[1:0] <= 2'b00;
			4'b0001: tens_binary[1:0] <= 2'b01;
			4'b0010: tens_binary[1:0] <= 2'b10;
			4'b0011: tens_binary[1:0] <= 2'b11;
			default: tens_binary[1:0] <= 2'b00;
		endcase
		
		// Convert ones digit of hours from binary to BCD
		case(hh_binary[3:0])
			4'b0000: ones_binary[3:0] <= 4'b0000;
			4'b0001: ones_binary[3:0] <= 4'b0001;
			4'b0010: ones_binary[3:0] <= 4'b0010;
			4'b0011: ones_binary[3:0] <= 4'b0011;
			4'b0100: ones_binary[3:0] <= 4'b0100;
			4'b0101: ones_binary[3:0] <= 4'b0101;
			4'b0110: ones_binary[3:0] <= 4'b0110;
			4'b0111: ones_binary[3:0] <= 4'b0111;
			4'b1000: ones_binary[3:0] <= 4'b1000;
			4'b1001: ones_binary[3:0] <= 4'b1001;
			4'b1010: ones_binary[3:0] <= 4'b0000;
			4'b1011: ones_binary[3:0] <= 4'b0001;
			default: ones_binary[3:0] <= 4'b0000;
		endcase
		
		// Assign BCD values to outputs
		hh = {tens_binary, ones_binary};
		mm = {mm_binary[5:4], mm_binary[3:0]};
		ss = {ss_binary[5:4], ss_binary[3:0]};
	end

endmodule
