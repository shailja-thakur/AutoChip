module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    reg q_temp;

    always @(*) begin
        if (a == 0 && b == 0 && (c == 0 || d == 0))
            q_temp = 1;
        else if (a == 1 && b == 0 && (c == 0 || d == 1))
            q_temp = 0;
        else if (a == 1 && b == 0 && c == 1 && d == 0)
            q_temp = 1;
        else if (a == 1 && b == 0 && c == 1 && d == 1)
            q_temp = 0;
        else if (a == 1 && b == 1 && (c == 0 || d == 1))
            q_temp = 1;
        else
            q_temp = 1;
    end

    assign q = q_temp;

endmodule
