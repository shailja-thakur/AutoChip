module top_module (
    input clk,
    input j,
    input k,
    output Q);

    reg Qold;
    D flip_flop (
        input clk,
        input D,
        output Q
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