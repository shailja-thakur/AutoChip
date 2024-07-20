module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal variables
    reg [3:0] sec_ones, sec_tens;
    reg [3:0] min_ones, min_tens;
    reg [3:0] hour_ones, hour_tens;

    // Initial block to set the registers to default values
    initial begin
        pm = 1'b0;
        sec_ones = 4'd0;
        sec_tens = 4'd0;
        min_ones = 4'd0;
        min_tens = 4'd0;
        hour_ones = 4'd2;
        hour_tens = 4'd1;
    end

    // Combining BCD digits into the final output
    always @(*) begin
        ss = {sec_tens, sec_ones};
        mm = {min_tens, min_ones};
        hh = {hour_tens, hour_ones};
    end

    // Synchronous process block
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            pm <= 1'b0;
            sec_ones <= 4'd0;
            sec_tens <= 4'd0;
            min_ones <= 4'd0;
            min_tens <= 4'd0;
            hour_ones <= 4'd2;
            hour_tens <= 4'd1;
        end
        else if (ena) begin
            // Increment seconds
            if (sec_ones == 4'd9) begin
                sec_ones <= 4'd0;
                if (sec_tens == 4'd5) begin
                    sec_tens <= 4'd0;
                    // Increment minutes
                    if (min_ones == 4'd9) begin
                        min_ones <= 4'd0;
                        if (min_tens == 4'd5) begin
                            min_tens <= 4'd0;
                            // Increment hours
                            if (hour_ones == 4'd9 || (hour_tens == 1 && hour_ones == 4'd2)) begin
                                hour_ones <= 4'd0;
                                if (hour_tens == 4'd1) begin
                                    hour_tens <= 4'd0;
                                    pm <= ~pm; // Toggle AM/PM
                                end else begin
                                    if (hour_ones == 4'd9) begin
                                        hour_ones <= 4'd2;
                                        hour_tens <= 4'd1;
                                    end else begin
                                        hour_tens <= 4'd1;
                                    end
                                end
                            end else if (hour_ones == 4'd8 && hour_tens == 4'd0) begin
                                hour_ones <= 4'd9;
                                hour_tens <= 4'd0;
                            end else begin
                                hour_ones <= hour_ones + 4'd1;
                            end
                        end else begin
                            min_tens <= min_tens + 4'd1;
                        end
                    end else begin
                        min_ones <= min_ones + 4'd1;
                    end
                end else begin
                    sec_tens <= sec_tens + 4'd1;
                end
            end else begin
                sec_ones <= sec_ones + 4'd1;
            end
        end
    end
endmodule
