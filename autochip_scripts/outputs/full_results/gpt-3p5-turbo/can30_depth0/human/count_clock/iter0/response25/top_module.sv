module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [3:0] hours;
    reg [5:0] minutes;
    reg [5:0] seconds;
    
    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
            hh <= 8'd1;
            mm <= 8'd2;
            ss <= 8'd0;
        end
        else if (ena) begin
            seconds <= seconds + 1;
            
            if (seconds == 6'd60) begin
                seconds <= 0;
                minutes <= minutes + 1;
                
                if (minutes == 6'd60) begin
                    minutes <= 0;
                    hours <= hours + 1;
                    
                    if (hours == 4'd13) begin
                        hours <= 4'd1;
                        pm <= ~pm;
                    end
                    else if (hours == 4'd12 && pm) begin
                        pm <= 0;
                    end
                    else if (hours == 4'd12 && ~pm) begin
                        pm <= 1;
                    end
                end
            end
        end
    end
    
    assign hh = {4'b0, hours};
    assign mm = {4'b0, minutes};
    assign ss = {4'b0, seconds};
    
endmodule
