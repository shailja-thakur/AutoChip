module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] count;
reg [7:0] twos_comp;

always @(posedge clk or negedge areset) begin
    if (!areset) begin
        count <= 0;
        twos_comp <= 0;
    end else begin
        if (count < 8) begin
            twos_comp <= twos_comp + (x << count);
            count <= count + 1;
        end
    end
end

assign z = twos_comp;

endmodule
