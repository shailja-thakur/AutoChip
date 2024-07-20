module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 4'b0;
        tens <= 4'b0;
        hundreds <= 4'b0;
        thousands <= 4'b0;
    end
    else begin
        if (ones == 4'd9) begin
            ones <= 4'b0;
            ena[1] <= 1'b1;
        end
        else begin
            ones <= ones + 1'b1;
            ena[1] <= 1'b0;
        end

        if (ena[1] && tens == 4'd9) begin
            tens <= 4'b0;
            ena[2] <= 1'b1;
        end
        else if (ena[1]) begin
            tens <= tens + 1'b1;
            ena[2] <= 1'b0;
        end

        if (ena[2] && hundreds == 4'd9) begin
            hundreds <= 4'b0;
            ena[3] <= 1'b1;
        end
        else if (ena[2]) begin
            hundreds <= hundreds + 1'b1;
            ena[3] <= 1'b0;
        end

        if (ena[3] && thousands == 4'd9) begin
            thousands <= 4'b0;
        end
        else if (ena[3]) begin
            thousands <= thousands + 1'b1;
        end
    end

    q <= {thousands, hundreds, tens, ones};
end

endmodule
