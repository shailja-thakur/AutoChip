module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

    reg [3:0] hours_tens;
    reg [3:0] hours_ones;
    reg [3:0] mins_tens;
    reg [3:0] mins_ones;
    reg [3:0] secs_tens;
    reg [3:0] secs_ones;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset the clock to "12:00 AM"
            hours_tens <= 4'b0001;
            hours_ones <= 4'b0010;
            mins_tens <= 4'b0000;
            mins_ones <= 4'b0000;
            secs_tens <= 4'b0000;
            secs_ones <= 4'b0000;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment the clock every second
            secs_ones <= secs_ones + 1;
            if (secs_ones == 4'b1010) begin
                secs_ones <= 4'b0000;
                secs_tens <= secs_tens + 1;
                if (secs_tens == 4'b0110) begin
                    secs_tens <= 4'b0000;
                    mins_ones <= mins_ones + 1;
                    if (mins_ones == 4'b1010) begin
                        mins_ones <= 4'b0000;
                        mins_tens <= mins_tens + 1;
                        if (mins_tens == 4'b0110) begin
                            mins_tens <= 4'b0000;
                            hours_ones <= hours_ones + 1;
                            if (hours_ones == 4'b1010 || (hours_ones == 4'b0010 && hours_tens == 4'b0001)) begin
                                hours_ones <= 4'b0000;
                                hours_tens <= hours_tens + 1;
                                if (hours_tens == 4'b1101) begin
                                    hours_tens <= 4'b0001;
                                    pm <= ~pm;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    assign hh = {hours_tens, hours_ones};
    assign mm = {mins_tens, mins_ones};
    assign ss = {secs_tens, secs_ones};
    
endmodule
