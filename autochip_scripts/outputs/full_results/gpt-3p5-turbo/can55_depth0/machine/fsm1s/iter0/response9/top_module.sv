module top_module (
    input wire clk,
    input wire in,
    input wire reset,
    output wire out
);

    // Parameters
    parameter STATE_A = 1'b0;
    parameter STATE_B = 1'b1;

    // Internal signals
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;
        end else begin
            if (state == STATE_A) begin
                state <= in ? STATE_A : STATE_B;
            end else if (state == STATE_B) begin
                state <= in ? STATE_B : STATE_A;
            end else begin
                state <= STATE_B; // Default state, set to STATE_B
            end
        end
    end

    assign out = (state == STATE_B) ? 1'b1 : 1'b0;

endmodule
