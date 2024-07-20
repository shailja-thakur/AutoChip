module top_module(
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
        // Reset the time to 12:00 AM
        hh <= 8'h12;  // Hours set to 12
        mm <= 8'h00;  // Minutes set to 00
        ss <= 8'h00;  // Seconds set to 00
        pm <= 1'b0;   // AM
    end else if (ena) begin
        // Increment the seconds
        if (ss[3:0] == 4'h9) begin
            ss[3:0] <= 4'h0;
            if (ss[7:4] == 4'h5) begin
                ss[7:4] <= 4'h0;
                
                // Increment the minutes
                if (mm[3:0] == 4'h9) begin
                    mm[3:0] <= 4'h0;
                    if (mm[7:4] == 4'h5) begin
                        mm[7:4] <= 4'h0;
                        
                        // Increment the hours
                        if (hh[3:0] == 4'h9) begin
                            hh[3:0] <= 4'h0;
                            hh[7:4] <= hh[7:4] + 1;
                        end else if (hh[3:0] == 4'h2 && hh[7:4] == 4'h1) begin
                            hh <= 8'h01;  // Roll over to 01
                            pm <= ~pm;    // Toggle AM/PM
                        end else begin
                            hh[3:0] <= hh[3:0] + 1;
                        end
                    end else begin
                        mm[7:4] <= mm[7:4] + 1;
                    end
                end else begin
                    mm[3:0] <= mm[3:0] + 1;
                end
            end else begin
                ss[7:4] <= ss[7:4] + 1;
            end
        end else begin
            ss[3:0] <= ss[3:0] + 1;
        end
    end
end

endmodule
