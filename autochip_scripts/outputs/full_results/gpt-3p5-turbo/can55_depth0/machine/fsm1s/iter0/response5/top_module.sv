module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg state;
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            if (state == 0 && in) begin
                state <= 0;
            end else if (state == 0 && !in) begin
                state <= 1;
            end else if (state == 1 && in) begin
                state <= 1;
            end else if (state == 1 && !in) begin
                state <= 0;
            end
        end
    end
    
    assign out = (state == 1) ? 1 : 0;

endmodule
