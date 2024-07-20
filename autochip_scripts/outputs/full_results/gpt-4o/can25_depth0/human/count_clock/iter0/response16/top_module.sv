module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
    );

    // Initialize the counters and PM indicator
    initial begin
        hh = 8'd12;   // 12:00 AM startup value
        mm = 8'd0;
        ss = 8'd0;
        pm = 1'b0;    // Start at AM
    end

    // Always block for synchronous reset and enable
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset resets the time to 12:00 AM
            hh <= 8'd12;
            mm <= 8'd0;
            ss <= 8'd0;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment the seconds
            if (ss == 8'd59) begin
                ss <= 8'd0;
                // Increment the minutes if seconds roll over
                if (mm == 8'd59) begin
                    mm <= 8'd0;
                    // Increment the hours if minutes roll over
                    if (hh == 8'd12) begin
                        hh <= 8'd1;
                        pm <= ~pm;  // Toggle AM/PM indicator
                    end
                    else if (hh == 8'd11) begin
                        hh <= hh + 8'd1;
                        pm <= ~pm;  // Toggle AM/PM indicator when going from 11 to 12
                    end
                    else begin
                        hh <= hh + 8'd1;
                    end
                end
                else begin
                    mm <= mm + 8'd1;
                end
            end
            else begin
                ss <= ss + 8'd1;
            end
        end
    end
endmodule
