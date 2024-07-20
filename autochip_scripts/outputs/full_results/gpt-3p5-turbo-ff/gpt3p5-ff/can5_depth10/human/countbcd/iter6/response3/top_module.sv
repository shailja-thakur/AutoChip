module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:0] q_ones;
    reg [3:0] q_tens;
    reg [3:0] q_hundreds;
    reg [3:0] q_thousands;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_ones <= 0;
            q_tens <= 0;
            q_hundreds <= 0;
            q_thousands <= 0;
        end else begin
            if (ena[1] && q[3:0] == 9) begin
                q_ones <= 0;
                if (ena[2] && q[7:4] == 9) begin
                    q_tens <= 0;
                    if (ena[3] && q[11:8] == 9) begin
                        q_hundreds <= 0;
                        if (q[15:12] != 9) begin
                            q_thousands <= q_thousands + 1;
                        end
                    end else if (ena[3]) begin
                        q_hundreds <= q_hundreds + 1;
                    end
                end else if (ena[2]) begin
                    q_tens <= q_tens + 1;
                end
            end else if (ena[1]) begin
                q_ones <= q_ones + 1;
            end
        end
    end

    assign ena[1] = (q_ones == 9);
    assign ena[2] = (q_tens == 9);
    assign ena[3] = (q_hundreds == 9);

    assign q = {q_thousands, q_hundreds, q_tens, q_ones};

endmodule
