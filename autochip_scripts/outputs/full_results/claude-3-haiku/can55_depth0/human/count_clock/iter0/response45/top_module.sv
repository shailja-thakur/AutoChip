module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

reg [7:0] seconds;
reg [7:0] minutes;
reg [7:0] hours;

always @(posedge clk) begin
    if (reset) begin
        seconds <= 8'h00;
        minutes <= 8'h00;
        hours <= 8'h12;
        pm <= 1'b0;
    end
    else if (ena) begin
        // Increment seconds
        if (seconds == 8'h59) begin
            seconds <= 8'h00;
            // Increment minutes
            if (minutes == 8'h59) begin
                minutes <= 8'h00;
                // Increment hours
                if (hours == 8'h12) begin
                    hours <= 8'h01;
                    pm <= ~pm;
                end
                else begin
                    hours <= hours + 8'h01;
                end
            end
            else begin
                minutes <= minutes + 8'h01;
            end
        end
        else begin
            seconds <= seconds + 8'h01;
        end
    end
end

assign hh = hours;
assign mm = minutes;
assign ss = seconds;

endmodule
