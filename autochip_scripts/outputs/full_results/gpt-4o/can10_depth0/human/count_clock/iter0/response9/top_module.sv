module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD counters
    reg [3:0] sec_l, sec_h; // Low and high digits for seconds
    reg [3:0] min_l, min_h; // Low and high digits for minutes
    reg [3:0] hour_l, hour_h; // Low and high digits for hours

    // Always block sensitive to the clock signal
    always @(posedge clk) begin
        
        if (reset) begin
            // Reset the clock to 12:00:00 AM
            pm <= 0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            sec_l <= 0;
            sec_h <= 0;
            min_l <= 0;
            min_h <= 0;
            hour_l <= 2;
            hour_h <= 1;
        end
        else if (ena) begin
            // Increment the seconds
            if (sec_l == 4'd9) begin
                sec_l <= 4'd0;
                if (sec_h == 4'd5) begin
                    sec_h <= 4'd0;
                    // Increment the minutes
                    if (min_l == 4'd9) begin
                        min_l <= 4'd0;
                        if (min_h == 4'd5) begin
                            min_h <= 4'd0;
                            // Increment the hours
                            if (hour_l == 4'd9) begin
                                hour_l <= 4'd0;
                                if (hour_h == 4'd1) begin
                                    hour_h <= 4'd2;
                                end else if (hour_h == 4'd2 && hour_l == 4'd1) begin
                                    hour_h <= 4'd1;
                                    hour_l <= 4'd2;
                                    pm <= ~pm; // Toggle AM/PM
                                end else begin
                                    hour_h <= hour_h + 4'd1;
                                end
                            end else if (hour_l == 4'd2 && hour_h == 4'd1) begin
                                hour_l <= 4'd1;
                            end else begin
                                hour_l <= hour_l + 4'd1;
                            end
                        end else begin
                            min_h <= min_h + 4'd1;
                        end
                    end else begin
                        min_l <= min_l + 4'd1;
                    end
                end else begin
                    sec_h <= sec_h + 4'd1;
                end
            end else begin
                sec_l <= sec_l + 4'd1;
            end
        end

        // Update BCD outputs based on counter values
        ss <= {sec_h, sec_l};
        mm <= {min_h, min_l};
        hh <= {hour_h, hour_l};
    end
endmodule
