module top_module (
    input wire clk,
    input wire in,
    input wire areset,
    output reg out
);

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;
        out <= 1'b0;
    end else begin
        state <= next_state;
    end
end

always @(state, in) begin
    case (state)
        1'b0: begin
            if (in) begin
                next_state = 1'b0;
                out <= 1'b0;
            end else begin
                next_state = 1'b1;
                out <= 1'b1;
            end
        end
        1'b1: begin
            if (in) begin
                next_state = 1'b1;
                out <= 1'b1;
            end else begin
                next_state = 1'b0;
                out <= 1'b0;
            end
        end
    endcase
end

endmodule
