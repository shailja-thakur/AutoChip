module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal counters for hours, minutes, and seconds
    reg [3:0] sec_l, sec_h; // Seconds low and high BDC digits
    reg [3:0] min_l, min_h; // Minutes low and high BDC digits
    reg [3:0] hour_l, hour_h; // Hours low and high BDC digits

    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset to 12:00 AM
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 1'b0; // AM
            sec_l <= 4'h0;
            sec_h <= 4'h0;
            min_l <= 4'h0;
            min_h <= 4'h0;
            hour_l <= 4'h2;
            hour_h <= 4'h1;
        end
        else if (ena) begin
            // Increment seconds
            if (sec_l == 4'h9) begin
                sec_l <= 4'h0;
                if (sec_h == 4'h5) begin
                    sec_h <= 4'h0;
                    // Increment minutes
                    if (min_l == 4'h9) begin
                        min_l <= 4'h0;
                        if (min_h == 4'h5) begin
                            min_h <= 4'h0;
                            // Increment hours
                            if (hour_l == 4'h9 || hour_l == 4'h2) begin
                                hour_l <= 4'h1;
                                if (hour_h == 4'h1) begin
                                    hour_h <= 4'h0;
                                    pm <= ~pm; // Toggle AM/PM
                                end
                                else begin
                                    hour_h <= 4'h1;
                                end
                            end
                            else begin
                                hour_l <= hour_l + 4'h1;
                            end
                        end
                        else begin
                            min_h <= min_h + 4'h1;
                        end
                    end
                    else begin
                        min_l <= min_l + 4'h1;
                    end
                end
                else begin
                    sec_h <= sec_h + 4'h1;
                end
            end
            else begin
                sec_l <= sec_l + 4'h1;
            end

            // Assign counters to outputs
            ss <= {sec_h, sec_l};
            mm <= {min_h, min_l};
            hh <= {hour_h, hour_l};
        end
    end
endmodule
