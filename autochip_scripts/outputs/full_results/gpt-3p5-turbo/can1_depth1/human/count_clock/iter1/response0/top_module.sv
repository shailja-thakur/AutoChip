module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Declare internal signals
    reg [3:0] count_sec;
    reg [3:0] count_min;
    reg [3:0] count_hour;

    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pm <= 1'b0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
        end else begin
            // Increment counters every second
            if (ena) begin
                count_sec <= count_sec + 1;
                
                // Update minute counter every 60 seconds
                if (count_sec >= 4'd9) begin
                    count_sec <= 4'b0;
                    count_min <= count_min + 1;

                    // Update hour counter every 60 minutes
                    if (count_min >= 4'd9) begin
                        count_min <= 4'b0;
                        count_hour <= count_hour + 1;
                        
                        // Check if it's PM
                        if (count_hour == 4'h9 || count_hour == 4'h19) begin
                            pm <= 1'b1;
                        end else begin
                            pm <= 1'b0;
                        end
                    end
                end
            end
        end
    end

    // Convert counters to BCD (Binary-Coded Decimal)
    always @(count_sec, count_min, count_hour) begin
        hh <= {pm, count_hour[3:0]};
        mm <= count_min;
        ss <= count_sec;
    end

endmodule
