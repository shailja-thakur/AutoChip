module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if (reset) begin
            pm <= 1'b0;
            hh <= 8'b0001;
            mm <= 8'b0000;
            ss <= 8'b0000;
        end else if (ena) begin
            ss <= ss + 1;
            if (ss == 8'b01111010) begin // Check for seconds equal to 59
                ss <= 8'b0000;
                mm <= mm + 1;
                if (mm == 8'b01111010) begin // Check for minutes equal to 59
                    mm <= 8'b0000;
                    hh <= hh + 1;
                    if (hh == 8'b00011010) begin // Check for hours equal to 12
                        pm <= ~pm; // Toggle between AM and PM
                        hh <= 8'b0001;
                    end else if (hh == 8'b00011110) begin // Check for hours equal to 13
                        hh <= 8'b0000;
                    end
                end
            end
        end
    end
  
endmodule
