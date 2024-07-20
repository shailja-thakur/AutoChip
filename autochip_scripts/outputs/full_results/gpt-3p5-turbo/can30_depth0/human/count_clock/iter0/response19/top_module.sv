module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
    
    // Internal variables
    reg [7:0] count; // Counter for seconds
    reg [7:0] prev_count;

    always @(posedge clk) begin
        if (reset) begin
            // Reset to "12:00 AM"
            hh <= 8'b00010010; // 12 in BCD format
            mm <= 8'b00000000; // 00 in BCD format
            ss <= 8'b00000000; // 00 in BCD format
        end else if (ena && (count != prev_count)) begin
            // Increment the clock once per second
            if (ss == 8'b01011010) begin
                ss <= 8'b00000000; // Reset seconds to 00
                if (mm == 8'b01011010) begin
                    mm <= 8'b00000000; // Reset minutes to 00
                    if (hh == 8'b00010011) begin
                        hh <= 8'b00000000; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM indicator
                    end else begin
                        hh <= hh + 1; // Increment hours
                    end
                end else begin
                    mm <= mm + 1; // Increment minutes
                end
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end

        prev_count <= count;
        count <= count + 1;
    end

endmodule
