module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Temporary variables for tracking carry overs
    reg carry_ss;
    reg carry_mm;
    reg carry_hh;
    
    // Local parameters for BCD limits
    localparam [7:0] MAX_HH = 8'b00010010; // 12 in BCD
    localparam [7:0] MIN_HH = 8'b00000001; // 1 in BCD
    localparam [7:0] MAX_MM_SS = 8'b01011001; // 59 in BCD
    localparam [7:0] ZERO_BCD = 8'b00000000;

    // Synchronous process for the counters
    always @(posedge clk) begin
        if (reset) begin
            // Reset logic
            hh <= 8'b00010010; // 12 in BCD
            mm <= ZERO_BCD;    // 00 in BCD
            ss <= ZERO_BCD;    // 00 in BCD
            pm <= 1'b0;        // AM
        end 
        else if (ena) begin
            // Seconds counter
            if (ss == MAX_MM_SS) begin
                ss <= ZERO_BCD;
                carry_ss <= 1'b1;
            end else if (ss[3:0] == 4'd9) begin
                ss[3:0] <= 4'd0;
                ss[7:4] <= ss[7:4] + 4'd1;
                carry_ss <= 1'b0;
            end else begin
                ss <= ss + 8'd1;
                carry_ss <= 1'b0;
            end
            
            // Minutes counter
            if (carry_ss) begin
                if (mm == MAX_MM_SS) begin
                    mm <= ZERO_BCD;
                    carry_mm <= 1'b1;
                end else if (mm[3:0] == 4'd9) begin
                    mm[3:0] <= 4'd0;
                    mm[7:4] <= mm[7:4] + 4'd1;
                    carry_mm <= 1'b0;
                end else begin
                    mm <= mm + 8'd1;
                    carry_mm <= 1'b0;
                end
            end else begin
                carry_mm <= 1'b0;
            end
            
            // Hours counter
            if (carry_mm) begin
                if (hh == MAX_HH) begin
                    hh <= MIN_HH;
                    pm <= ~pm; // Toggle AM/PM
                end else if (hh == 8'b00010001) begin // Handle transition from 11 to 12
                    hh <= 8'b00010010; // 12 in BCD
                    pm <= ~pm; // Toggle AM/PM
                end else if (hh[3:0] == 4'd9) begin
                    hh[3:0] <= 4'd0;
                    hh[7:4] <= hh[7:4] + 4'd1;
                end else begin
                    hh <= hh + 8'd1;
                end
            end
        end
    end

endmodule
