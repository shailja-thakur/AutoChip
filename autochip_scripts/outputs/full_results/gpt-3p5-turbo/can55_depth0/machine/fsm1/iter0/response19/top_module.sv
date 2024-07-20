module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;
wire clk_posedge;
assign clk_posedge = clk && !areset;

always @(posedge clk_posedge) begin
    if (areset) begin
        state <= 1'b0;
    end else begin
        if (state) begin
            if (in) begin
                state <= 1'b1;
            end else begin
                state <= 1'b0;
            end
        end else begin
            if (in) begin
                state <= 1'b0;
            end else begin
                state <= 1'b1;
            end
        end
    end
end

assign out = state ? 1'b1 : 1'b0;

endmodule
