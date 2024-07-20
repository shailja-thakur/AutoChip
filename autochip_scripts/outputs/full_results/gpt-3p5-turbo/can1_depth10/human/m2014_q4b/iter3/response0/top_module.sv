module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

    reg q_ff;

    always_ff @(posedge clk, posedge ar)
    begin
        if (!ar)
            q_ff <= 1'b0;
        else
            q_ff <= d;
    end

    always @(posedge clk)
    begin
        q = q_ff;
    end

endmodule
