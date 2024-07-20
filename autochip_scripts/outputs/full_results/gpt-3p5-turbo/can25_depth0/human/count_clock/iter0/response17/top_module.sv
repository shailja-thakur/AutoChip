module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] hr_ones;
    reg [1:0] hr_tens;
    reg [3:0] min_ones;
    reg [5:0] min_tens;
    reg [3:0] sec_ones;
    reg [5:0] sec_tens;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh <= 8'b00000000;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 0;
            hr_ones <= 4'b0000;
            hr_tens <= 2'b00;
            min_ones <= 4'b0000;
            min_tens <= 6'b000000;
            sec_ones <= 4'b0000;
            sec_tens <= 6'b000000;
        end else if (ena) begin
            if (sec_ones == 4'b1001 && sec_tens == 6'b010110)
                min_ones <= min_ones + 4'b0001;
            
            if (min_ones == 4'b1001 && min_tens == 6'b010110)
                hr_ones <= hr_ones + 4'b0001;

            if (hr_ones == 4'b1010 && hr_tens == 2'b0001)
                hr_ones <= 4'b0000;
            
            if (sec_ones == 4'b1010 && sec_tens == 6'b000110)
                sec_tens <= 6'b000000;
            
            if (min_ones == 4'b1010 && min_tens == 6'b000110)
                min_tens <= 6'b000000;
            
            if (hr_ones == 4'b1010 && hr_tens == 2'b0001)
                hr_tens <= 2'b00;
            
            if (sec_ones == 4'b1001 && sec_tens == 6'b001110)
                sec_ones <= 4'b0000;
                       
            if (ena) begin
                       
                if (ena && clk % 2'd1 == 0)
                    ss <= ss + 1;
                
                if (sec_ones == 4'b1010 && sec_tens == 6'b010110)
                    sec_ones <= 4'b0000;
                
                if (aa && hr_ones < 4'b1001)
                    hr_ones <= hr_ones + 1;
                
                if (aa && hr_ones == 4'b1001 && hr_tens < 2'b0001)
                    hr_tens <= hr_tens + 1;
            end
        end
    end
endmodule
