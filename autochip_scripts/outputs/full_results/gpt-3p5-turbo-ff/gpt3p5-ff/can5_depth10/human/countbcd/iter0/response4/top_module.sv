module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] digit_ones;
reg [3:0] digit_tens;
reg [3:0] digit_hundreds;
reg [3:0] digit_thousands;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        digit_ones <= 4'b0000;
        digit_tens <= 4'b0000;
        digit_hundreds <= 4'b0000;
        digit_thousands <= 4'b0000;
        q <= 16'b0000000000000000;
    end else begin
        if (ena[1]) begin
            if (digit_ones == 9) begin
                digit_ones <= 4'b0000;
                digit_tens <= digit_tens + 1;
            end else begin
                digit_ones <= digit_ones + 1;
            end
        end

        if (ena[2]) begin
            if (digit_tens == 9) begin
                digit_tens <= 4'b0000;
                digit_hundreds <= digit_hundreds + 1;
            end else begin
                digit_tens <= digit_tens + 1;
            end
        end

        if (ena[3]) begin
            if (digit_hundreds == 9) begin
                digit_hundreds <= 4'b0000;
                digit_thousands <= digit_thousands + 1;
            end else begin
                digit_hundreds <= digit_hundreds + 1;
            end
        end

        q[3:0] = digit_ones;
        q[7:4] = digit_tens;
        q[11:8] = digit_hundreds;
        q[15:12] = digit_thousands;
    end
end

endmodule
