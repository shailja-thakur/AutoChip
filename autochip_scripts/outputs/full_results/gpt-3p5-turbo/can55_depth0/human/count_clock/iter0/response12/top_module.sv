module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [3:0] count_seconds;
    reg [3:0] count_minutes;
    reg [3:0] count_hours;
    reg [3:0] hours_tens;
    reg [3:0] hours_ones;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count_seconds <= 4'b0000;
            count_minutes <= 4'b0000;
            count_hours <= 4'b0000;
            pm <= 1'b0;
            hh <= 8'b00000000;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
        end else if (ena) begin
            count_seconds <= count_seconds + 1;
            if (count_seconds == 4'b1010) begin
                count_seconds <= 4'b0000;
                count_minutes <= count_minutes + 1;
                if (count_minutes == 4'b0110) begin
                    count_minutes <= 4'b0000;
                    count_hours <= count_hours + 1;
                    if (count_hours == 4'b1100) begin
                        count_hours <= 4'b0000;
                    end
                end
            end
        end
    end
    
    always @(*) begin
        if (count_hours >= 4'b1100) begin
            pm <= 1'b1;
            hours_tens <= count_hours[3];
            hours_ones <= count_hours[2:0];
        end else begin
            pm <= 1'b0;
            hours_tens <= count_hours[3];
            hours_ones <= count_hours[2:0];
        end
        
        hh = {hours_tens, hours_ones};
        mm = {count_minutes[3:0], count_minutes[3:0]};
        ss = {count_seconds[3:0], count_seconds[3:0]};
    end

endmodule
