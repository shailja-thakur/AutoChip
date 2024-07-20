module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j == 1'b0 && k == 1'b0) begin
        Q <= Q; // Q retains its value
    end else if (j == 1'b0 && k == 1'b1) begin
        Q <= 1'b0; // Q is reset
    end else if (j == 1'b1 && k == 1'b0) begin
        Q <= 1'b1; // Q is set
    end else if (j == 1'b1 && k == 1'b1) begin
        Q <= ~Q; // Q toggles
    end
end

endmodule
