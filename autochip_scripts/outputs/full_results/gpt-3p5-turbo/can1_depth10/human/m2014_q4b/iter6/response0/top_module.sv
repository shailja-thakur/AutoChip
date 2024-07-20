module top_module (
    input wire clk,
    input wire d,
    input wire ar,
    output wire q
);

    reg q_ff;
    reg ar_ff;

    always_ff @(posedge clk or posedge ar)
    begin
        if (!ar)
        begin
            q_ff <= 1'b0;
            ar_ff <= 1'b1;
        end
        else if (ar)
        begin
            q_ff <= d;
            ar_ff <= 1'b0;
        end
    end

    always @(posedge clk)
    begin
        if (ar_ff)
            q <= 1'b0;
        else
            q <= q_ff;
    end

endmodule
