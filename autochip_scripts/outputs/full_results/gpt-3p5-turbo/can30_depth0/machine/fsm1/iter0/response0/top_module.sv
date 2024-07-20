module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        0: begin
            if (in) begin
                next_state = 0;
            end else begin
                next_state = 1;
            end
        end
        1: begin
            if (in) begin
                next_state = 1;
            end else begin
                next_state = 0;
            end
        end
    endcase
end

assign out = (state == 1);

endmodule
