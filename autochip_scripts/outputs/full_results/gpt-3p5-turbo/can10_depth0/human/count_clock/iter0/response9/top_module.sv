module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    always @(posedge clk) begin
        if (reset)
            begin
                hh <= 8'b0001;   // Set hh to 01
                mm <= 8'b0000;   // Set mm to 00
                ss <= 8'b0000;   // Set ss to 00
                pm <= 1'b0;      // Set pm to AM
            end
        else if (ena)
            begin
                ss <= ss + 1;    // Increment seconds
                if (ss == 8'b01101111)   // If ss reaches 59
                    begin
                        ss <= 8'b0000;   // Reset ss to 00
                        mm <= mm + 1;    // Increment minutes
                        if (mm == 8'b01101111)   // If mm reaches 59
                            begin
                                mm <= 8'b0000;   // Reset mm to 00
                                hh <= hh + 1;    // Increment hours
                                if (hh == 8'b00001101)   // If hh reaches 12
                                    pm <= ~pm;   // Toggle pm (AM to PM, PM to AM)
                            end
                    end
            end
    end
endmodule
