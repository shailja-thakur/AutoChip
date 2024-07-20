module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] hours;
    reg [3:0] minutes;
    reg [5:0] seconds;

    always @(posedge clk) begin
        if (reset) begin
            hours <= 4'b0001; // 12 in BCD
            minutes <= 4'b0000;
            seconds <= 6'b000000;
            pm <= 1'b0; // AM
        end else begin
            if (ena) begin
                if (seconds == 59) begin
                    seconds <= 6'b000000;
                    if (minutes == 59) begin
                        minutes <= 4'b0000;
                        if (hours == 4'b1100) begin
                            hours <= 4'b0001; // 12 in BCD
                            pm <= ~pm; // toggle AM/PM
                        end else begin
                            hours <= hours + 1;
                        end
                    end else begin
                        minutes <= minutes + 1;
                    end
                end else begin
                    seconds <= seconds + 1;
                end
            end
        end
    end

    assign hh = {2'b0, hours};
    assign mm = {2'b0, minutes};
    assign ss = seconds;
    
endmodule
