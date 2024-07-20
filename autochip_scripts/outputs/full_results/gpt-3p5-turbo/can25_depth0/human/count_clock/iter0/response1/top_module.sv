module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        hh <= 8'b00010010; // set hh to "12"
        mm <= 8'b00000000; // set mm to "00"
        ss <= 8'b00000000; // set ss to "00"
        pm <= 1'b0; // set PM indicator to AM
    end else begin
        if (ena) begin
            ss <= ss + 1; // increment seconds
            if (ss >= 8'b01101100) begin
                ss <= 8'b00000000; // reset seconds when it reaches "60"
                mm <= mm + 1; // increment minutes
                
                if (mm >= 8'b01111000) begin
                    mm <= 8'b00000000; // reset minutes when it reaches "60"
                    hh <= hh + 1; // increment hours
                    
                    if (hh >= 8'b00011000) begin
                        hh <= 8'b00000001; // reset hours when it reaches "13"
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end
        end
    end
end

endmodule
