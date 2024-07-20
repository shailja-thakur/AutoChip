module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b0 && k == 1'b0) begin
        // Q remains unchanged
        Q <= Q;
    end else if (j == 1'b0 && k == 1'b1) begin
        // Q is reset
        Q <= 1'b0;
    end else if (j == 1'b1 && k == 1'b0) begin
        // Q is set
        Q <= 1'b1;
    end else if (j == 1'b1 && k == 1'b1) begin
        // Q is toggled
        Q <= ~Q;
    end
end

endmodule
