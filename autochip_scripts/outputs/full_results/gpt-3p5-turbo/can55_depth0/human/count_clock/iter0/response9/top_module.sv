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
            hh <= 8'b00010001; // 12 in BCD
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 1'b0; // AM
        end else if (ena) begin
            ss <= ss + 8'b00000001;
            
            if (ss == 8'b01101000) begin // 60 in BCD
                ss <= 8'b00000000;
                mm <= mm + 8'b00000001;
            end
            
            if (mm == 8'b01101000) begin // 60 in BCD
                mm <= 8'b00000000;
                hh <= hh + 8'b00000001;
                
                if (hh == 8'b00011010) begin // 13 in BCD
                    hh <= 8'b00010001; // 12 in BCD
                    
                    if (pm == 1'b0) begin
                        pm <= 1'b1; // PM
                    end else begin
                        pm <= 1'b0; // AM
                    end
                end
            end
        end
    end
endmodule
