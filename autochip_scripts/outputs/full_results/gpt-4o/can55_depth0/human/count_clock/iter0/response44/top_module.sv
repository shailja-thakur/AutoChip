module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal counters
    reg [3:0] sec_l, sec_h;
    reg [3:0] min_l, min_h;
    reg [3:0] hour_l, hour_h;

    always @(posedge clk) begin
        if (reset) begin
            // Asynchronous reset to "12:00 AM"
            ss <= 8'b0000_0000; // 00 seconds
            mm <= 8'b0000_0000; // 00 minutes
            hh <= 8'b0000_0001; // 12 hours as BCD 0001 0010
            pm <= 0; // AM
        end
        else if (ena) begin
            // Increment seconds
            if (sec_l == 4'd9) begin
                sec_l <= 4'd0;
                
                if (sec_h == 4'd5) begin
                    sec_h <= 4'd0;
                    // Increment minutes
                    if (min_l == 4'd9) begin
                        min_l <= 4'd0;
                        
                        if (min_h == 4'd5) begin
                            min_h <= 4'd0;
                            // Increment hours
                            if (hour_l == 4'd9) begin
                                hour_l <= 4'd0;
                                hour_h <= hour_h + 1;
                            end
                            else begin
                                hour_l <= hour_l + 4'd1;
                            end
                            
                            // Handle 12-hour clock AM/PM
                            if ((hour_h == 4'd1 && hour_l == 4'd2) || (hour_h == 4'd0 && hour_l == 4'd0)) begin
                                if (hour_h == 4'd1) begin
                                    hour_h <= 4'd0;
                                    hour_l <= 4'd1;
                                    pm <= ~pm;
                                end
                                else if (hour_h == 4'd0 && hour_l == 4'd0) begin
                                    hour_h <= 4'd0;
                                    hour_l <= 4'd1;
                                    pm <= 0; // Reset to AM after 12:00 PM
                                end
                            end
                        end
                        else begin
                            min_h <= min_h + 4'd1;
                        end
                    end
                    else begin
                        min_l <= min_l + 4'd1;
                    end
                end
                else begin
                    sec_h <= sec_h + 4'd1;
                end
            end
            else begin
                sec_l <= sec_l + 4'd1;
            end
            
            // Update outputs
            ss <= {sec_h, sec_l};
            mm <= {min_h, min_l};
            hh <= {hour_h, hour_l};
        end
    end
endmodule
