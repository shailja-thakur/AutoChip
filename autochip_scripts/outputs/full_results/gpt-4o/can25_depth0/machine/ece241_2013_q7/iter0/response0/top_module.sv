module top (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 0 && k == 0) begin
        // Q remains unchanged
        Q <= Q;
    end else if (j == 0 && k == 1) begin
        // Q is reset to 0
        Q <= 0;
    end else if (j == 1 && k == 0) begin
        // Q is set to 1
        Q <= 1;
    end else if (j == 1 && k == 1) begin
        // Q is toggled
        Q <= ~Q;
    end
end

endmodule
