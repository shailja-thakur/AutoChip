module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Helper task to increment BCD value
    task increment_bcd;
        input [7:0] bcd;
        output [7:0] result;
        begin
            if (bcd[3:0] == 4'd9) begin
                result[3:0] = 4'd0;
                result[7:4] = bcd[7:4] + 4'd1;
            end else begin
                result[3:0] = bcd[3:0] + 4'd1;
                result[7:4] = bcd[7:4];
            end
        end
    endtask

    // Synchronous logic triggered by clk
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            ss <= 8'b00000000;
            mm <= 8'b00000000;
            hh <= 8'b00010010; // 12 in BCD
            pm <= 1'b0; // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b01011001) begin
                ss <= 8'b00000000;
                
                // Increment minutes
                if (mm == 8'b01011001) begin
                    mm <= 8'b00000000;
                    
                    // Increment hours
                    if (hh == 8'b00010010) begin // 12
                        hh <= 8'b00000001; // 1
                        pm <= ~pm; // Toggle AM/PM
                    end else begin
                        increment_bcd(hh, hh);
                        if (hh == 8'b00010010 && !pm) begin
                            pm <= 1'b0; // AM again after PM 12:00
                        end
                    end
                end else begin    
                    increment_bcd(mm, mm);
                end
            end else begin
                increment_bcd(ss, ss);
            end
        end
    end
endmodule
