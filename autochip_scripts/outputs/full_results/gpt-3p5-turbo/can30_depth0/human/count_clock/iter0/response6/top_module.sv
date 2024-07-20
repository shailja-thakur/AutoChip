module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal counters
    reg [7:0] hours;
    reg [7:0] minutes;
    reg [7:0] seconds;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the clock to "12:00 AM"
            pm <= 0;
            hh <= 8'b0001;
            mm <= 8'b0011;
            ss <= 8'b0000;

            hours <= 8'b0001;
            minutes <= 8'b0000;
            seconds <= 8'b0000;
        end else if (ena) begin
            // Increment the clock by one second
            seconds <= seconds + 1;

            if (seconds >= 8'b0110) begin
                seconds <= 8'b0000;
                minutes <= minutes + 1;

                if (minutes >= 8'b1100) begin
                    minutes <= 8'b0000;
                    hours <= hours + 1;

                    if (hours >= 8'b1101) begin
                        hours <= 8'b0001;

                        // Toggle AM/PM indicator
                        pm <= ~pm;
                    end
                end
            end
        end
    end

    // Assign the BCD outputs
    assign hh = {4'h0, hours};
    assign mm = {4'h0, minutes};
    assign ss = {4'h0, seconds};

endmodule
