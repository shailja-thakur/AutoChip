module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
reg next_state;

always @(*) begin
    case (state)
        1'b0: begin // State A
            if (j) begin
                next_state = 1'b1; // Go to State B
            end else begin
                next_state = 1'b0; // Stay in State A
            end
        end
        1'b1: begin // State B
            if (k) begin
                next_state = 1'b0; // Go to State A
            end else begin
                next_state = 1'b1; // Stay in State B
            end
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to State A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    if (state == 1'b1) begin
        out = 1'b1; // Output is high in State B
    end else begin
        out = 1'b0; // Output is low in State A
    end
end

endmodule
