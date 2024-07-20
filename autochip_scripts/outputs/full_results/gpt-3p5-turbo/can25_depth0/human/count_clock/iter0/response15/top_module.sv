module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if(reset) begin
            hh <= 8'b00010011; // Set hh to 12
            mm <= 8'b00000000; // Set mm to 00
            ss <= 8'b00000000; // Set ss to 00
            pm <= 1'b0; // Set PM indicator to AM
        end else if(ena) begin
            ss <= ss + 1; // Increment seconds
            if(ss >= 8'b01101001) begin // If seconds reach 60, reset to 0
                ss <= 8'b00000000;
                mm <= mm + 1; // Increment minutes
                if(mm >= 8'b01101001) begin // If minutes reach 60, reset to 0
                    mm <= 8'b00000000;
                    hh <= hh + 1; // Increment hours
                    if(hh >= 8'b00011010) begin // If hours reach 13, reset to 1 (AM)
                        hh <= 8'b00000001;
                        pm <= ~pm; // Toggle AM/PM indicator
                    end
                end
            end
        end
    end
    
endmodule
