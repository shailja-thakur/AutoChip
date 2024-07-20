module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [7:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            hh <= 8'b00000001;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 1'b0;
        end else if (ena) begin
            count <= count + 1;
        end
    end

    always @(count) begin
        if (count == 10) begin
            ss <= ss + 1;
            count <= 0;
        end

        if (ss == 10) begin
            mm <= mm + 1;
            ss <= 0;
        end

        if (mm == 60) begin
            hh <= hh + 1;
            mm <= 0;
        end

        if (hh == 13) begin
            hh <= 8'b00000001;
            pm <= ~pm;
        end
    end

endmodule
