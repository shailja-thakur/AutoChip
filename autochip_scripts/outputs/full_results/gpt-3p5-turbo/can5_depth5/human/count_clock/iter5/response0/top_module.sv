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
    reg [1:0] hours_tens;
    reg [3:0] hours_ones;
    reg [5:0] minutes;
    reg [5:0] seconds;
    reg [23:0] count = 0;

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010;  // Set initial value to 12 AM
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 1'b0;
            count <= 0;
        end else if (ena) begin
            // Calculate next values
            seconds = ss + 1;
            minutes = mm;
            hours_tens = hh[7:6];
            hours_ones = hh[5:2];

            if (seconds == 8'b01101000) begin
                seconds <= 8'b00000000;  // Reset seconds to 0
                minutes <= mm + 1;      // Increment minutes
                if (minutes == 8'b01101000) begin
                    minutes <= 8'b00000000;  // Reset minutes to 0
                    hours_ones <= hh_ones + 1;      // Increment hours ones digit
                    if (hours_ones == 8'b00001111) begin
                        hours_ones <= 8'b00000000;  // Reset hours ones digit to 0
                        hours_tens <= hh_tens + 1;      // Increment hours tens digit
                        if (hours_tens == 2'b0001) begin
                            hours_tens <= 2'b0000;  // Reset hours tens digit to 0
                            pm <= ~pm;          // Toggle AM/PM indicator
                        end else if (hours_tens == 2'b0000) begin
                            hours_tens <= 2'b0001;  // Reset hours tens digit to 1
                            pm <= ~pm;          // Toggle AM/PM indicator
                        end
                    end
                end
            end

            // Assign the next values to the outputs
            ss <= seconds;
            mm <= minutes;
            hh <= {hours_tens, hours_ones};
        
            count <= count + 1;
        end
    end

    always @(posedge clk) begin
        if (count == 24_000_000) begin
            count <= 0;
        end
    end

endmodule
