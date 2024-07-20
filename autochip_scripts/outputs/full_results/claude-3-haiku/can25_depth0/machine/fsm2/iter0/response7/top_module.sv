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
                next_state = 1'b1; // Next state is B
            end else begin
                next_state = 1'b0; // Next state is A
            end
        end
        1'b1: begin // State B
            if (k) begin
                next_state = 1'b0; // Next state is A
            end else begin
                next_state = 1'b1; // Next state is B
            end
        end
        default: begin
            next_state = 1'b0; // Default to state A
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to state A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    if (state == 1'b1) begin
        out = 1'b1; // Output is high when in state B
    end else begin
        out = 1'b0; // Output is low when in state A
    end
end

endmodule
