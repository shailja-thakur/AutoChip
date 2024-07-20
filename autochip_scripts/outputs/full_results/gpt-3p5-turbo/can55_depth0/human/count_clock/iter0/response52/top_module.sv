module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
	
    // Create a counter to keep track of the number of clock ticks
    reg [31:0] counter;
    
    always @(posedge clk) begin
        // Reset the clock when reset signal is high
        if (reset)
            counter <= 0;
        else if (ena)
            counter <= counter + 1;
    end	

    // Create counters for hours, minutes, and seconds
    reg [7:0] hour_counter;
    reg [7:0] minute_counter;
    reg [7:0] second_counter;
    
    always @(posedge clk) begin
        // Reset the clock to "12:00 AM" when reset signal is high
        if (reset) begin
            hour_counter <= 8'b0001; // 12 in BCD
            minute_counter <= 8'b0000; // 00 in BCD
            second_counter <= 8'b0000; // 00 in BCD
        end
        else if (ena) begin
            // Increment the seconds counter every second
            if (counter == 0) begin
                second_counter <= second_counter + 1;
                
                // Reset the seconds counter to 00 when it reaches 60
                if (second_counter == 8'b0110_0000) // 60 in BCD
                    second_counter <= 8'b0000; // 00 in BCD
                
                // Increment the minutes counter every minute
                if (second_counter == 8'b0000) begin
                    minute_counter <= minute_counter + 1;
                    
                    // Reset the minutes counter to 00 when it reaches 60
                    if (minute_counter == 8'b0110_0000) // 60 in BCD
                        minute_counter <= 8'b0000; // 00 in BCD
                    
                    // Increment the hours counter every hour
                    if (minute_counter == 8'b0000) begin
                        hour_counter <= hour_counter + 1;
                        
                        // Reset the hours counter to 01 when it reaches 12
                        if (hour_counter == 8'b0001_0010) // 12 in BCD
                            hour_counter <= 8'b0001; // 01 in BCD
                        
                        // Toggle the am/pm indicator based on the hour
                        pm <= (hour_counter >= 8'b0001_0100); // 14 in BCD is PM, else AM
                    end
                end
            end
        end
    end
    
    // Connect the outputs to the correct BCD digit values
    assign hh = {pm, hour_counter};
    assign mm = minute_counter;
    assign ss = second_counter;
    
endmodule
