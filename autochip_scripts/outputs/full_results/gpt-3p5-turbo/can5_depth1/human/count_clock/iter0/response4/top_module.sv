module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // set hours to 12
            mm <= 8'b00000000; // set minutes to 0
            ss <= 8'b00000000; // set seconds to 0
            pm <= 1'b0; // set AM
        end else if (ena) begin
            ss <= ss + 1; // increment seconds
            
            if (ss == 8'b01101000) begin // if seconds overflow, set seconds to 0 and increment minutes
                ss <= 8'b00000000;
                mm <= mm + 1; // increment minutes
                
                if (mm == 8'b00110000) begin // if minutes overflow, set minutes to 0 and increment hours
                    mm <= 8'b00000000;
                    
                    if (hh[5:4] == 2'b0001) begin // if 10 hours digit is 1, set it to 0 
                        hh[5:4] <= 2'b00;
                    end else if (hh[7:4] == 4'b1010) begin // if 10 hours digit is 9, set it to 0 and increment AM/PM indicator
                        hh[7:4] <= 4'b0000;
                        pm <= ~pm;
                    end else if (hh[7:4] == 4'b1001) begin // if 10 hours digit is 8, set it to 9
                        hh[7:4] <= 4'b1001;
                    end else begin // increment 10 hours digit normally
                        hh[7:4] <= hh[7:4] + 1;
                    end
                    
                    if (hh[3:0] == 4'b1001) begin // if 1 hours digit is 9, set it to 0
                        hh[3:0] <= 4'b0000;
                    end else begin // increment 1 hours digit normally
                        hh[3:0] <= hh[3:0] + 1;
                    end
                end
            end
        end
    end

endmodule
