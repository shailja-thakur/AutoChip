module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Reset the clock to "12:00 AM"
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 0;
        end
        else if (ena) begin
            if (ss == 8'b01011001) begin // 59 seconds
                ss <= 8'b00000000; // reset seconds to 00
                if (mm == 8'b01011001) begin // 59 minutes
                    mm <= 8'b00000000; // reset minutes to 00
                    if (hh == 8'b00010010) begin // 12 hours
                        hh <= 8'b00000001; // reset hours to 01
                        pm <= ~pm; // toggle pm
                    end else if (hh == 8'b00010001) begin // 11 hours
                        hh <= 8'b00010010; // increment to 12 hours
                    end else begin
                        hh <= hh + 8'b00000001; // increment hours
                    end
                end else if ((mm[3:0] == 4'b1001) && (mm[7:4] != 4'b0101)) begin
                    mm <= {mm[7:4] + 1, 4'b0000}; // increment tens place, reset ones place
                end else begin
                    mm <= mm + 8'b00000001; // increment ones place
                end
            end else if ((ss[3:0] == 4'b1001) && (ss[7:4] != 4'b0101)) begin
                ss <= {ss[7:4] + 1, 4'b0000}; // increment tens place, reset ones place
            end else begin
                ss <= ss + 8'b00000001; // increment ones place
            end
        end
    end
    
endmodule
