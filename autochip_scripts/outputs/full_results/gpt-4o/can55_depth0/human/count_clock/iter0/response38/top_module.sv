module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal BCD counters for hours, minutes, and seconds
    reg [3:0] tens_sec, units_sec;
    reg [3:0] tens_min, units_min;
    reg [3:0] tens_hour, units_hour;
    
    // Convert BCD counters into two-digit outputs
    always @(*) begin
        ss = {tens_sec, units_sec};
        mm = {tens_min, units_min};
        hh = {tens_hour, units_hour};
    end

    always @(posedge clk) begin
        if (reset) begin
            // Reset clock to "12:00 AM"
            tens_sec  <= 4'd0;
            units_sec <= 4'd0;
            tens_min  <= 4'd0;
            units_min <= 4'd0;
            tens_hour <= 4'd1;
            units_hour <= 4'd2;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (units_sec == 4'd9) begin
                units_sec <= 4'd0;
                if (tens_sec == 4'd5) begin
                    tens_sec <= 4'd0;
                    // Increment minutes
                    if (units_min == 4'd9) begin
                        units_min <= 4'd0;
                        if (tens_min == 4'd5) begin
                            tens_min <= 4'd0;
                            // Increment hours
                            if (units_hour == 4'd9 || 
                                (tens_hour == 4'd1 && units_hour == 4'd2)) begin
                                units_hour <= 4'd0;
                                if (tens_hour == 4'd1 && units_hour == 4'd2) begin
                                    tens_hour <= 4'd0;
                                    pm = ~pm;
                                end
                                else begin
                                    tens_hour <= tens_hour + 4'd1;
                                end
                            end
                            else begin
                                units_hour <= units_hour + 4'd1;
                            end
                        end
                        else begin
                            tens_min <= tens_min + 4'd1;
                        end
                    end
                    else begin
                        units_min <= units_min + 4'd1;
                    end
                end
                else begin
                    tens_sec <= tens_sec + 4'd1;
                end
            end
            else begin
                units_sec <= units_sec + 4'd1;
            end
        end
    end

endmodule
