module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:0] ones;
    reg [3:0] tens;
    reg [3:0] hundreds;
    reg [3:0] thousands;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ones <= 4'b0;
            tens <= 4'b0;
            hundreds <= 4'b0;
            thousands <= 4'b0;
        end else begin
            if (ena[1]) begin
                if (ones == 4'b1001) begin
                    ones <= 4'b0000;
                    tens <= tens + 1;
                end else begin
                    ones <= ones + 1;
                end
            end
            
            if (ena[2]) begin
                if (tens == 4'b1001) begin
                    tens <= 4'b0000;
                    hundreds <= hundreds + 1;
                end else begin
                    tens <= tens + 1;
                end
            end
            
            if (ena[3]) begin
                if (hundreds == 4'b1001) begin
                    hundreds <= 4'b0000;
                    thousands <= thousands + 1;
                end else begin
                    hundreds <= hundreds + 1;
                end
            end
        end
    end

    assign q = {thousands, hundreds, tens, ones};

endmodule
