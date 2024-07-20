module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

    reg [3:0] q_ones;
    reg [3:0] q_tens;
    reg [3:0] q_hundreds;
    reg [3:0] q_thousands;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
            q_ones <= 0;
            q_tens <= 0;
            q_hundreds <= 0;
            q_thousands <= 0;
        end else begin
            ena <= {q_thousands == 9, q_hundreds == 9, q_tens == 9};
            if (ena[1]) begin
                if (q_ones == 9) begin
                    q_ones <= 0;
                end else begin
                    q_ones <= q_ones + 1;
                end
            end
            if (ena[2]) begin
                if (q_tens == 9) begin
                    q_tens <= 0;
                end else begin
                    q_tens <= q_tens + 1;
                end
            end
            if (ena[3]) begin
                if (q_hundreds == 9) begin
                    q_hundreds <= 0;
                end else begin
                    q_hundreds <= q_hundreds + 1;
                end
            end
            if (q_ones == 9 && q_tens == 9 && q_hundreds == 9 && q_thousands != 9) begin
                q_ones <= 0;
                q_tens <= 0;
                q_hundreds <= 0;
                q_thousands <= q_thousands + 1;
            end
            q[3:0] <= q_ones;
            q[7:4] <= q_tens;
            q[11:8] <= q_hundreds;
            q[15:12] <= q_thousands;
        end
    end
endmodule
