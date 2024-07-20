module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    // Declare the internal signals for the digit values
    reg [3:0] ones, tens, hundreds, thousands;

    // Combinational logic to generate the enable signals
    assign ena[1] = (tens == 4'b1001) || (hundreds == 4'b1001) || (thousands == 4'b1001);
    assign ena[2] = (hundreds == 4'b1001) || (thousands == 4'b1001);
    assign ena[3] = (thousands == 4'b1001);

    // Synchronous counter logic
    always @(posedge clk) begin
        if (reset) begin
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
        end
        else begin
            ones <= (ones == 4'b1001) ? 0 : ones + 1;
            if (ena[1]) tens <= (tens == 4'b1001) ? 0 : tens + 1;
            if (ena[2]) hundreds <= (hundreds == 4'b1001) ? 0 : hundreds + 1;
            if (ena[3]) thousands <= (thousands == 4'b1001) ? 0 : thousands + 1;
        end
    end

    // Combine the digit values into the output signal
    always @(*) begin
        q[3:0] = ones;
        q[7:4] = tens;
        q[11:8] = hundreds;
        q[15:12] = thousands;
    end

endmodule
