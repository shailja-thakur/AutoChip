module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] count_sec; // Counter for seconds
    reg [7:0] count_min; // Counter for minutes
    reg [7:0] count_hour; // Counter for hours

    always @(posedge clk) begin
        if (reset) begin
            count_sec <= 8'd0; // Reset seconds counter to 00
            count_min <= 8'd0; // Reset minutes counter to 00
            count_hour <= 8'd0; // Reset hours counter to 00
            hh <= 8'd12; // Reset output hours to 12
            mm <= 8'd0; // Reset output minutes to 00
            ss <= 8'd0; // Reset output seconds to 00
            pm <= 1'b0; // Reset pm indicator to AM
        end else if (ena) begin
            count_sec <= count_sec + 1; // Increment seconds counter
            if (count_sec == 8'd59) begin
                count_sec <= 8'd0; // Reset seconds counter to 00 when reaches 59
                count_min <= count_min + 1; // Increment minutes counter
                
                if (count_min == 8'd59) begin
                    count_min <= 8'd0; // Reset minutes counter to 00 when reaches 59
                    count_hour <= count_hour + 1; // Increment hours counter
                    
                    if (count_hour == 8'd11 && !pm) begin
                        pm <= 1'b1; // Switch to PM when reaches 11 AM
                    end else if (count_hour == 8'd12) begin
                        pm <= 1'b0; // Switch back to AM when reaches 12 PM
                    end else if (count_hour >= 8'd13) begin
                        count_hour <= 8'd1; // Reset hours counter to 01 when reaches 12 PM
                    end
                end
            end
        end
        
        // Convert binary counters to BCD format for outputs
        hh <= {4'b0, pm, count_hour}; // BCD format for hours
        mm <= {4'b0, count_min}; // BCD format for minutes
        ss <= {4'b0, count_sec}; // BCD format for seconds
    end

endmodule
