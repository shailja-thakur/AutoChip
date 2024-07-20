module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD limits
    localparam MAX_SEC_MIN = 8'h59;  // 59 in BCD
    localparam MAX_HOUR = 8'h12;     // 12 in BCD
    
    // Clock initialization
    initial begin
        hh = 8'h12; // 12
        mm = 8'h00; // 00
        ss = 8'h00; // 00
        pm = 0;     // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // Reset to 12
            mm <= 8'h00; // Reset to 00
            ss <= 8'h00; // Reset to 00
            pm <= 0;     // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == MAX_SEC_MIN) begin
                ss <= 8'h00;
                
                // Increment minutes
                if (mm == MAX_SEC_MIN) begin
                    mm <= 8'h00;
                    
                    // Increment hours
                    if (hh == MAX_HOUR) begin
                        hh <= 8'h01; // Wrap around to 1
                        pm <= ~pm;   // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else begin
                        hh <= hh + 1;
                    end
                end else begin
                    mm <= mm + 1;
                end
            end else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
