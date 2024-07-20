module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Create registers to hold the values of hours, minutes, and seconds
    reg [7:0] hours_reg;
    reg [7:0] minutes_reg;
    reg [7:0] seconds_reg;
    
    // Create a counter to count the number of clock cycles
    reg [31:0] counter;
    
    // Declare parameter constants
    parameter [7:0] MAX_HOUR = 12;
    parameter [7:0] MAX_MINUTE = 59;
    parameter [7:0] MAX_SECOND = 59;
    
    always @(posedge clk) begin
        // Check if reset is active high and reset the clock if true
        if (reset)
            counter <= 0;
        else begin
            // Increment the counter if enable is active and counter is less than the maximum value
            if (ena && counter < 999_999_999)
                counter <= counter + 1;
            
            // Update the time values based on the counter
            if (counter % 1_000_000_000 == 0) begin
                seconds_reg <= seconds_reg + 1;
                if (seconds_reg > MAX_SECOND) begin
                    seconds_reg <= 0;
                    minutes_reg <= minutes_reg + 1;
                    if (minutes_reg > MAX_MINUTE) begin
                        minutes_reg <= 0;
                        hours_reg <= hours_reg + 1;
                        if (hours_reg > MAX_HOUR) begin
                            hours_reg <= 0;
                        end
                    end
                end
            end
        end
    end
    
    always @(*) begin
        // Assign the BCD values to the outputs
        pm = (hours_reg >= 12);
        hh = {pm ? (hours_reg - 12) : hours_reg};
        mm = minutes_reg;
        ss = seconds_reg;
    end
endmodule
