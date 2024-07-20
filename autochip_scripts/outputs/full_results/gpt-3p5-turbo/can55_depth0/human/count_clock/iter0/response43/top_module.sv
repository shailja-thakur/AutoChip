module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Counter for seconds
    reg [3:0] sec_counter;
    
    // Counter for minutes
    reg [3:0] min_counter;
    
    // Counter for hours
    reg [3:0] hour_counter;
    
    // AM/PM indicator
    reg prev_reset;
    always @(posedge reset or posedge clk) begin
        if (reset && !prev_reset) begin
            pm <= 0;
            hh <= 8'b0001;
            mm <= 8'b0011;
            ss <= 8'b0000;
        end else if (reset) begin
            hh <= 8'b0001;
            mm <= 8'b0011;
            ss <= 8'b0000;
        end else if (ena && sec_counter == 4'b0111) begin
            if (min_counter == 4'b0101 && hour_counter[3] == 1'b0 && hour_counter[2:0] == 4'b0101) begin
                pm <= ~pm;
            end
            if (mm == 8'b0011 && ss == 8'b0101 && hour_counter[3] == 1'b0 && hour_counter[2:0] == 4'b0101) begin
                hh <= hh + 8'b0001;
            end 
            if (ss == 8'b0101) begin
                mm <= mm + 8'b0001;
            end
            ss <= ss + 8'b0001;
        end
    end
    
    // Synchronous counters
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sec_counter <= 4'b0000;
            min_counter <= 4'b0000;
            hour_counter <= 4'b0000;
        end else if (ena) begin
            if (sec_counter == 4'b0111) begin
                sec_counter <= 4'b0000;
                if (min_counter == 4'b0101) begin
                    min_counter <= 4'b0000;
                    if (hour_counter[3] == 1'b1 && hour_counter[2:0] == 4'b0101) begin
                        hour_counter <= 4'b0000;
                    end else if (hour_counter[2:0] == 4'b1001) begin
                        hour_counter <= hour_counter + 4'b0010;
                    end else begin
                        hour_counter <= hour_counter + 4'b0001;
                    end
                end else begin
                    min_counter <= min_counter + 4'b0001;
                end
            end else begin
                sec_counter <= sec_counter + 4'b0001;
            end
        end
    end
    
endmodule
