module top_module (
    input clk,
    input j,
    input k,
    output Q);

    reg Qold;
    D-type flip_flop (
        .D(Qold),
        .Q(Q),
        .C(clk)
    );

    always @(posedge clk) begin
        if (j == 1 && k == 1) begin
            Q <= ~Qold;
        end else if (j == 1) begin
            Q <= 1;
        end else if (k == 1) begin
            Q <= 0;
        end else begin
            Q <= Qold;
        end
    end

endmodule