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
            q_ones <= 0;
            q_tens <= 0;
            q_hundreds <= 0;
            q_thousands <= 0;
            ena <= 0;
        end else begin
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
                    ena[2] <= 1;
                end
            end else begin
                q_ones <= q_ones + 1;
                ena[1] <= 1;
            end
        end
    end

    always @(posedge clk) begin
        if (ena[1]) ena[1] <= 0;
        if (ena[2]) ena[2] <= 0;
        if (q_hundreds == 9) ena[3] <= 1;
        else ena[3] <= 0;
    end

    assign q = {q_thousands, q_hundreds, q_tens, q_ones};

endmodule
