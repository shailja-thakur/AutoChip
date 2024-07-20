module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh <= 8'b00000001; // Reset to 12
            mm <= 8'b00000000; // Reset to 00
            ss <= 8'b00110000; // Reset to 00
            pm <= 1'b0; // Reset to AM
        end else if (ena) begin
            if (ss == 8'b00111001) begin // Check if seconds reach '59'
                ss <= 8'b00110000; // Reset seconds to '00'
                if (mm == 8'b00111001) begin // Check if minutes reach '59'
                    mm <= 8'b00000000; // Reset minutes to '00'
                    if (hh == 8'b00001111) begin // Check if hours reach '12'
                        hh <= 8'b00000001; // Reset hours to '01'
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b00001001) begin // Check if hours reach '09'
                        hh <= 8'b00001010; // Increment hours from '09' to '10'
                    end else begin
                        hh <= hh + 1; // Increment hours
                    end
                end else if (mm == 8'b00001001) begin // Check if minutes reach '09'
                    mm <= 8'b00001010; // Increment minutes from '09' to '10'
                end else begin
                    mm <= mm + 1; // Increment minutes
                end
            end else if (ss == 8'b00001001) begin // Check if seconds reach '09'
                ss <=  8'b00001010; // Increment seconds from '09' to '10'
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end
endmodule
