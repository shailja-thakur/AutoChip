module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

reg current_state, next_state;

always @(*) begin
    if (current_state == 1'b0) begin
        next_state = (j == 1'b1) ? 1'b1 : 1'b0;
    end
    else begin // current_state == 1'b1
        next_state = (k == 1'b1) ? 1'b0 : 1'b1;
    end
end

always @(posedge clk) begin
    if (areset == 1'b1) begin
        current_state <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

assign out = current_state;

endmodule
