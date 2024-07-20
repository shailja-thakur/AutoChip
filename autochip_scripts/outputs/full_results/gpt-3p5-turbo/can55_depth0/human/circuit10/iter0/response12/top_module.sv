module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg next_state;

always @(posedge clk) begin
    state <= next_state;
    q <= state;
    case (state)
        0: begin
            if (a && !b) begin
                next_state <= 1;
                q <= 0;
            end else if (a || b) begin
                next_state <= 0;
                q <= 1;
            end else begin
                next_state <= 0;
                q <= 0;
            end
        end
        1: begin
            if (a && !b) begin
                next_state <= 1;
                q <= 0;
            end else if (a || b) begin
                next_state <= 1;
                q <= 1;
            end else begin
                next_state <= 0;
                q <= 1;
            end
        end
    endcase
end

endmodule
