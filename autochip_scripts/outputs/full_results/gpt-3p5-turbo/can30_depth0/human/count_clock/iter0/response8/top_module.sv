module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

    reg [3:0] second_counter;
    reg [3:0] minute_counter;
    reg [3:0] hour_counter;
    
    always @(posedge clk) begin
        if (reset)
            begin
                pm <= 0;
                hh <= 8'b0001;
                mm <= 8'b0000;
                ss <= 8'b0000;
            end
        else if (ena)
            begin
                second_counter <= second_counter + 4'b0001;
                
                if (second_counter >= 4'b1010)
                    begin
                        second_counter <= 4'b0000;
                        mm <= mm + 8'b0001;
                        
                        if (mm >= 8'b01100011)
                            begin
                                mm <= 8'b00000000;
                                hh <= hh + 8'b00000001;
                                
                                if (hh >= 8'b00011001)
                                    begin
                                        hh <= 8'b00000001;
                                        
                                        if (pm)
                                            pm <= 0;
                                        else
                                            pm <= 1;
                                    end
                            end
                    end
            end
    end
endmodule
