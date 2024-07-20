module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [6:0] counter_hh; 
    reg [6:0] counter_mm; 
    reg [6:0] counter_ss; 
   
    always @(posedge clk) begin
        if (reset) begin
            counter_hh <= 7'b0010010;
            counter_mm <= 7'b0000000;
            counter_ss <= 7'b0000000;
            pm <= 1'b0;
        end else begin
            if (ena) begin
                counter_ss <= counter_ss + 1;
                if (counter_ss == 7'b01101000) begin
                    counter_ss <= 7'b0000000;
                    counter_mm <= counter_mm + 1;
                    if (counter_mm == 7'b01111000) begin
                        counter_mm <= 7'b0000000;
                        counter_hh <= counter_hh + 1;
                        if (counter_hh == 7'b0010011) begin
                            counter_hh <= 7'b0000001;
                            pm <= ~pm;
                        end
                        else if (counter_hh == 7'b0101001) begin
                            counter_hh <= 7'b0001010;
                        end
                        else if (counter_hh == 7'b0110000) begin
                            counter_hh <= 7'b0000001;
                        end
                        else if (counter_hh == 7'b0110001) begin
                            counter_hh <= 7'b0001010;
                        end
                        else if (counter_hh == 7'b0100111) begin
                            counter_hh <= 7'b0000001;
                        end
                        else if (counter_hh == 7'b0111101) begin
                            counter_hh <= 7'b0000001;
                            pm <= ~pm;
                        end
                        else if (counter_hh == 7'b0010000) begin
                            counter_hh <= 7'b0001000;
                        end
                        else if (counter_hh == 7'b0010001) begin
                            counter_hh <= 7'b0001001;
                        end
                        else if (counter_hh == 7'b0010100) begin
                            counter_hh <= 7'b0001001;
                        end
                        else if (counter_hh == 7'b0010101) begin
                            counter_hh <= 7'b0001001;
                        end
                        else if (counter_hh == 7'b0010110) begin
                            counter_hh <= 7'b0001001;
                        end
                        else if (counter_hh == 7'b0010111) begin
                            counter_hh <= 7'b0001100;
                        end
                        else if (counter_hh == 7'b0011000) begin
                            counter_hh <= 7'b0000001;
                        end
                        else if (counter_hh == 7'b0011001) begin
                            counter_hh <= 7'b0000001;
                        end
                    end
                end
            end
        end       
    end
    
    assign hh = counter_hh;
    assign mm = counter_mm;
    assign ss = counter_ss;
    
endmodule
