module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [7:0] hh_next;
    reg [7:0] mm_next;
    reg [7:0] ss_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pm <= 1'b0;
            hh <= 8'b00010010; // Initialize hours to 12 AM
            mm <= 8'b00000000; // Initialize minutes to 00
            ss <= 8'b00000000; // Initialize seconds to 00
        end else begin
            if (ena) begin
                ss_next = ss + 1;
                mm_next = mm;
                hh_next = hh;
                
                if (ss_next == 60) begin
                    ss_next = 0;
                    mm_next = mm + 1;
                    
                    if (mm_next == 60) begin
                        mm_next = 0;
                        hh_next = hh + 1;
                        
                        if (hh_next == 13) begin
                            hh_next = 1;
                            pm = ~pm; // Toggle AM/PM indicator
                        end
                    end
                end
            end
            
            ss <= ss_next;
            mm <= mm_next;
            hh <= hh_next;
        end
    end
    
endmodule
