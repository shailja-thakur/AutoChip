module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Counter variables
    reg [3:0] hours_tens;
    reg [3:0] hours_ones;
    reg [3:0] minutes_tens;
    reg [3:0] minutes_ones;
    reg [3:0] seconds_tens;
    reg [3:0] seconds_ones;

    // Clock counter
    reg [4:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the clock to 12:00 AM
            hours_tens <= 1'b0;
            hours_ones <= 4'b0001;
            minutes_tens <= 4'b0000;
            minutes_ones <= 4'b0000;
            seconds_tens <= 4'b0000;
            seconds_ones <= 4'b0000;

            // Reset the counter
            counter <= 5'b00000;
        end else if (ena) begin
            // Increment the counter every second
            if (counter == 5'b11110) begin
                counter <= 5'b00000;

                // Increment the seconds
                if (seconds_ones == 4'b1001) begin
                    seconds_ones <= 4'b0000;

                    if (seconds_tens == 4'b0110) begin
                        seconds_tens <= 4'b0000;

                        // Increment the minutes
                        if (minutes_ones == 4'b1001) begin
                            minutes_ones <= 4'b0000;

                            if (minutes_tens == 4'b0110) begin
                                minutes_tens <= 4'b0000;

                                // Increment the hours
                                if (hours_ones == 4'b1001 && hours_tens == 1'b0) begin
                                    hours_ones <= 4'b0000;
                                end else if (hours_ones == 4'b1001 && hours_tens == 1'b1) begin
                                    hours_ones <= 4'b0000;
                                    hours_tens <= 1'b0;
                                end else if (hours_ones != 4'b1001) begin
                                    hours_ones <= hours_ones + 1'b1;
                                end
                            end else begin
                                minutes_tens <= minutes_tens + 1'b1;
                            end
                        end else begin
                            minutes_ones <= minutes_ones + 1'b1;
                        end
                    end else begin
                        seconds_tens <= seconds_tens + 1'b1;
                    end
                end else begin
                    seconds_ones <= seconds_ones + 1'b1;
                end
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

    // Control the AM/PM indicator
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pm <= 1'b0; // Reset to AM
        end else begin
            if (hours_tens == 1'b1 && hours_ones >= 4'b1010) begin
                pm <= 1'b1; // PM
            end else begin
                pm <= 1'b0; // AM
            end
        end
    end

    // Output the BCD values for hours, minutes, and seconds
    assign hh = {hours_tens, hours_ones};
    assign mm = {minutes_tens, minutes_ones};
    assign ss = {seconds_tens, seconds_ones};
endmodule
