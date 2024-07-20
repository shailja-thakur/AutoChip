module top_module(
    input      clk,
    input      reset,
    input      ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [3:0] hours_tens;
    reg [3:0] hours_ones;
    reg [5:0] minutes_tens;
    reg [3:0] minutes_ones;
    reg [5:0] seconds_tens;
    reg [3:0] seconds_ones;

    always @(posedge clk) begin
        if (reset) begin
            pm = 0;
            hours_tens = 0;
            hours_ones = 0;
            minutes_tens = 0;
            minutes_ones = 0;
            seconds_tens = 0;
            seconds_ones = 0;
        end else if (ena) begin
            if (seconds_ones == 9) begin
                seconds_ones = 0;
                if (seconds_tens == 5) begin
                    seconds_tens = 0;
                    if (minutes_ones == 9) begin
                        minutes_ones = 0;
                        if (minutes_tens == 5) begin
                            minutes_tens = 0;
                            if (hours_ones == 9 && hours_tens == 0) begin
                                hours_ones = 0;
                                hours_tens = 1;
                            end else if (hours_ones == 2 && hours_tens == 1) begin
                                hours_ones = 0;
                                hours_tens = 0;
                            end else begin
                                hours_ones = hours_ones + 1;
                            end
                        end else begin
                            minutes_ones = minutes_ones + 1;
                        end
                    end else begin
                        seconds_tens = seconds_tens + 1;
                    end
                end else begin
                    seconds_ones = seconds_ones + 1;
                end
            end else begin
                seconds_ones = seconds_ones + 1;
            end
        end

        if (hours_tens == 1 && hours_ones == 2) begin
            pm = 1;
        end else begin
            pm = 0;
        end

        hh = {hours_tens, hours_ones};
        mm = {minutes_tens, minutes_ones};
        ss = {seconds_tens, seconds_ones};
    end
endmodule
