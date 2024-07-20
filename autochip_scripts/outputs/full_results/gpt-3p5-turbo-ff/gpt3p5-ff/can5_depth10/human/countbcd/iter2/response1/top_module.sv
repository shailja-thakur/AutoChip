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
            if (ena[3]) begin
                if (q_ones == 9) begin
                    q_ones <= 0;
                    if (q_tens == 9) begin
                        q_tens <= 0;
                        if (q_hundreds == 9) begin
                            q_hundreds <= 0;
                            if (q_thousands == 9) begin
                                q_thousands <= 0;
                            end else begin
                                q_thousands <= q_thousands + 1;
                            end
                        end else begin
                            q_hundreds <= q_hundreds + 1;
                        end
                    end else begin
                        q_tens <= q_tens + 1;
                    end
                end else begin
                    q_ones <= q_ones + 1;
                end
            end
        end
    end

    assign ena[1] = (q_ones == 9);
    assign ena[2] = (q_tens == 9);
    assign ena[3] = (q_hundreds == 9);

    assign q[3:0] = q_ones;
    assign q[7:4] = q_tens;
    assign q[11:8] = q_hundreds;
    assign q[15:12] = q_thousands;

endmodule
