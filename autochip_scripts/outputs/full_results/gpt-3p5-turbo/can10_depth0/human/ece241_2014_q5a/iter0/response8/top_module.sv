module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [31:0] num;
reg [31:0] complement;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        num <= 0;
        complement <= 0;
    end else begin
        num <= {num[30:0], x};
        if (num[31] == 1) begin
            complement <= ~num[31:0] + 1;
        end else begin
            complement <= num[31:0];
        end
    end
end

assign z = complement;

endmodule
