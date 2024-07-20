module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Convert 2-digit BCD to integer and vice versa
    function integer bcd_to_int(input [7:0] bcd);
        bcd_to_int = bcd[7:4] * 10 + bcd[3:0];
    endfunction
    
    function [7:0] int_to_bcd(input integer val);
        int_to_bcd = { (val / 10) % 10, val % 10 };
    endfunction

    // Internal registers to hold integer values of hh, mm, and ss
    integer int_hh, int_mm, int_ss;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset clock to 12:00 AM
            hh <= 8'b00010010; // 12
            mm <= 8'b00000000; // 00
            ss <= 8'b00000000; // 00
            pm <= 0; // AM
        end else if (ena) begin
            // Increment seconds
            int_ss = bcd_to_int(ss);
            int_ss = (int_ss + 1) % 60;
            ss <= int_to_bcd(int_ss);
            
            // Increment minutes if seconds wrapped around
            if (int_ss == 0) begin
                int_mm = bcd_to_int(mm);
                int_mm = (int_mm + 1) % 60;
                mm <= int_to_bcd(int_mm);
                
                // Increment hours if minutes wrapped around
                if (int_mm == 0) begin
                    int_hh = bcd_to_int(hh);
                    int_hh = (int_hh % 12) + 1;
                    hh <= int_to_bcd(int_hh);
                    
                    // Toggle AM/PM if hours wrapped around 12
                    if (int_hh == 12)
                        pm <= ~pm;
                end
            end
        end
    end
    
endmodule
