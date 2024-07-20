module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;
localparam STATE_A = 1'b0, STATE_B = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_B;
    end
    else begin
        if (state == STATE_A) begin
            if (in) begin
                state <= STATE_A;
            end
            else begin
                state <= STATE_B;
            end
        end
        else begin // state == STATE_B
            if (in) begin
                state <= STATE_B;
            end
            else begin
                state <= STATE_A;
            end
        end
    end
end

assign out = (state == STATE_B);

endmodule
