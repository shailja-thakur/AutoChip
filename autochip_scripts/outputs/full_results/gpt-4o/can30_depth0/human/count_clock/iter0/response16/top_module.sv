module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // Internal signals for BCD representation
    reg [3:0] sec_units;  // Units place for seconds
    reg [3:0] sec_tens;   // Tens place for seconds
    reg [3:0] min_units;  // Units place for minutes
    reg [3:0] min_tens;   // Tens place for minutes
    reg [3:0] hour_units; // Units place for hours
    reg [3:0] hour_tens;  // Tens place for hours

    // Initialization
    initial begin
        pm = 0;
        sec_units = 4'd0;
        sec_tens = 4'd0;
        min_units = 4'd0;
        min_tens = 4'd0;
        hour_units = 4'd2;
        hour_tens = 4'd1;
        hh = {hour_tens, hour_units};
        mm = {min_tens, min_units};
        ss = {sec_tens, sec_units};
    end

    // Clocking block
    always @(posedge clk) begin
        if (reset) begin
            // Reset the clock to 12:00 AM
            pm <= 0;
            sec_units <= 4'd0;
            sec_tens <= 4'd0;
            min_units <= 4'd0;
            min_tens <= 4'd0;
            hour_units <= 4'd2;
            hour_tens <= 4'd1;
        end
        else if (ena) begin
            // Increment seconds
            if (sec_units == 4'd9) begin
                sec_units <= 0;
                if (sec_tens == 4'd5) begin
                    sec_tens <= 0;
                    // Increment minutes
                    if (min_units == 4'd9) begin
                        min_units <= 0;
                        if (min_tens == 4'd5) begin
                            min_tens <= 0;
                            // Increment hours
                            if (hour_units == 4'd9) begin
                                hour_units <= 0;
                                hour_tens <= hour_tens + 1;
                                if (hour_tens == 4'd1 && hour_units == 4'd2) begin
                                    hour_tens <= 1;
                                    hour_units <= 2;
                                    pm <= ~pm; // Switch AM/PM
                                end
                            end
                            else if (hour_units == 4'd3 && hour_tens == 4'd1) begin
                                hour_units <= 1;
                                hour_tens <= 0;
                                pm <= ~pm; // Switch AM/PM
                            end
                            else begin
                                hour_units <= hour_units + 1;
                            end
                        end
                        else begin
                            min_tens <= min_tens + 1;
                        end
                    end
                    else begin
                        min_units <= min_units + 1;
                    end
                end
                else begin
                    sec_tens <= sec_tens + 1;
                end
            end
            else begin
                sec_units <= sec_units + 1;
            end
        end
        
        // Outputs
        hh <= {hour_tens, hour_units};
        mm <= {min_tens, min_units};
        ss <= {sec_tens, sec_units};
    end
endmodule
