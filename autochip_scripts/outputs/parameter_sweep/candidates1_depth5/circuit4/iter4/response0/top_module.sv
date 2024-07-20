module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    reg q_temp;

    always @(*) begin
        if ((a & b) || (c & (~d)))
            q_temp = 1;
        else
            q_temp = 0;
    end

    always @(posedge clk) begin
        q <= q_temp;
    end

endmodule
