module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] count;
reg [7:0] sum;
reg [7:0] complement;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        count <= 0;
        sum <= 0;
        complement <= 0;
    end else begin
        if (x) begin
            count <= count + 1;
            sum <= sum + x;
            complement <= ~sum + 1;
        end
    end
end

assign z = complement;

endmodule
