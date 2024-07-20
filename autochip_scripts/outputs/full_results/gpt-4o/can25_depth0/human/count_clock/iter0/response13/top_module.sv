module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal signals for BCD digits
    reg [3:0] sec_units, sec_tens;
    reg [3:0] min_units, min_tens;
    reg [3:0] hour_units, hour_tens;

    // Initialize the clock to 12:00 AM
    initial begin
        pm = 0;
        sec_units = 0;
        sec_tens = 0;
        min_units = 0;
        min_tens = 0;
        hour_units = 2;
        hour_tens = 1;
    end

    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
            sec_units <= 0;
            sec_tens <= 0;
            min_units <= 0;
            min_tens <= 0;
            hour_units <= 2;
            hour_tens <= 1;
        end else if (ena) begin
            // Increase seconds
            if (sec_units == 9) begin
                sec_units <= 0;
                if (sec_tens == 5) begin
                    sec_tens <= 0;
                    // Increase minutes
                    if (min_units == 9) begin
                        min_units <= 0;
                        if (min_tens == 5) begin
                            min_tens <= 0;
                            // Increase hours
                            if (hour_units == 9) begin
                                hour_units <= 0;
                                if (hour_tens == 1) begin
                                    hour_tens <= 0;
                                    // Toggle AM/PM
                                    pm <= ~pm;
                                end else begin
                                    hour_tens <= 1;
                                    hour_units <= 1;
                                end
                            end else if (hour_units == 2 && hour_tens == 1) begin
                                hour_units <= 0;
                                hour_tens <= 1;
                                // Toggle AM/PM
                                pm <= ~pm;
                            end else begin
                                hour_units <= hour_units + 1;
                            end
                        end else begin
                            min_tens <= min_tens + 1;
                        end
                    end else begin
                        min_units <= min_units + 1;
                    end
                end else begin
                    sec_tens <= sec_tens + 1;
                end
            end else begin
                sec_units <= sec_units + 1;
            end
        end

        // Assign BCD digits to output ports
        hh <= {hour_tens, hour_units};
        mm <= {min_tens, min_units};
        ss <= {sec_tens, sec_units};
    end
endmodule
