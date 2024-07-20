module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal signal declaration
    reg [3:0] tens_sec;
    reg [3:0] units_sec;
    reg [3:0] tens_min;
    reg [3:0] units_min;
    reg [3:0] tens_hour;
    reg [3:0] units_hour;
    
    // Define the maximum values for mm and ss
    parameter MAX_TENS = 4'd5;
    parameter MAX_UNITS = 4'd9;
    parameter MAX_HOUR_TENS = 4'd1;
    parameter MAX_HOUR_UNITS = 4'd2;

    // Synchronous logic for resetting and incrementing the clock
    always @(posedge clk) begin
        if (reset) begin
            // Reset the counters to the start state 12:00 AM
            tens_sec <= 4'd0;
            units_sec <= 4'd0;
            tens_min <= 4'd0;
            units_min <= 4'd0;
            tens_hour <= 4'd1;
            units_hour <= 4'd2;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (units_sec == MAX_UNITS) begin
                units_sec <= 4'd0;
                if (tens_sec == MAX_TENS) begin
                    tens_sec <= 4'd0;
                    
                    // Increment minutes
                    if (units_min == MAX_UNITS) begin
                        units_min <= 4'd0;
                        if (tens_min == MAX_TENS) begin
                            tens_min <= 4'd0;

                            // Increment hours
                            if (units_hour == MAX_HOUR_UNITS) begin
                                units_hour <= 4'd0;
                                if (tens_hour == MAX_HOUR_TENS) begin
                                    tens_hour <= 4'd0;
                                    // Toggle PM/AM status at 12:00
                                    pm <= ~pm;
                                end else begin
                                    tens_hour <= tens_hour + 4'd1;
                                end
                            end else if (units_hour == 4'd9) begin
                                units_hour <= 4'd0;
                                tens_hour <= tens_hour + 4'd1;
                            end else begin
                                units_hour <= units_hour + 4'd1;
                            end
                        end else begin
                            tens_min <= tens_min + 4'd1;
                        end
                    end else begin
                        units_min <= units_min + 4'd1;
                    end
                end else begin
                    tens_sec <= tens_sec + 4'd1;
                end
            end else begin
                units_sec <= units_sec + 4'd1;
            end
        end

        // Combine tens and units for final BCD output
        ss <= {tens_sec, units_sec};
        mm <= {tens_min, units_min};
        hh <= {tens_hour, units_hour};

        // Handle the special case when hours are exactly 12:00
        if ({tens_hour, units_hour} == 8'h00) begin
            hh <= 8'h12;  // Hours should wrap to 12 instead of 00
        end
    end
endmodule
