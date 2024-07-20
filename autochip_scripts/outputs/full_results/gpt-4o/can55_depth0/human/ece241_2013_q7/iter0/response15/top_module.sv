module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

    always @(posedge clk) begin
        if (j == 0 && k == 0) begin
            // Q remains the same
            Q <= Q;
        end
        else if (j == 0 && k == 1) begin
            // Q goes to 0
            Q <= 0;
        end
        else if (j == 1 && k == 0) begin
            // Q goes to 1
            Q <= 1;
        end
        else if (j == 1 && k == 1) begin
            // Q toggles
            Q <= ~Q;
        end
    end

endmodule
