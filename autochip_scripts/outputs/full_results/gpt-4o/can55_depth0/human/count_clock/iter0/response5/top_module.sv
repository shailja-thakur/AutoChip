module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Internal signals
    reg [3:0] sec_l, sec_h; // low and high BCD digits for seconds
    reg [3:0] min_l, min_h; // low and high BCD digits for minutes
    reg [3:0] hr_l, hr_h;   // low and high BCD digits for hours

    // Initialize outputs and internal signals
    initial begin
        sec_l = 4'd0; sec_h = 4'd0;
        min_l = 4'd0; min_h = 4'd0;
        hr_l = 4'd2; hr_h = 4'd1;
        pm = 0;
    end

    // Update clock on positive edge of clk
    always @(posedge clk) begin
        if (reset) begin
            // Reset to "12:00 AM"
            sec_l <= 4'd0; sec_h <= 4'd0;
            min_l <= 4'd0; min_h <= 4'd0;
            hr_l <= 4'd2; hr_h <= 4'd1;
            pm <= 0;
        end else if (ena) begin
            // Second Counters
            if (sec_l == 4'd9) begin
                sec_l <= 4'd0;
                if (sec_h == 4'd5) begin
                    sec_h <= 4'd0;

                    // Minute Counters
                    if (min_l == 4'd9) begin
                        min_l <= 4'd0;
                        if (min_h == 4'd5) begin
                            min_h <= 4'd0;

                            // Hour Counters
                            if (hr_l == 4'd9) begin
                                hr_l <= 4'd0;
                                if(hr_h == 4'd1) begin
                                    hr_h <= 4'd0;
                                    pm <= ~pm;
                                end else if (hr_h == 4'd0) begin
                                    hr_l <= hr_l + 1;
                                    if (hr_l == 4'd2) begin
                                        hr_l <= 4'd0;
                                        hr_h <= 4'd1;
                                    end
                                end
                            end else if (hr_l == 4'd2 && hr_h == 4'd1) begin
                                hr_l <= 4'd1;
                                hr_h <= 4'd0;
                                pm <= ~pm;
                            end else begin
                                hr_l <= hr_l + 1;
                            end
                        end else begin
                            min_h <= min_h + 1;
                        end
                    end else begin
                        min_l <= min_l + 1;
                    end
                end else begin
                    sec_h <= sec_h + 1;
                end
            end else begin
                sec_l <= sec_l + 1;
            end
        end
        
        // Update output
        hh <= {hr_h, hr_l};
        mm <= {min_h, min_l};
        ss <= {sec_h, sec_l};
    end
endmodule
