module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00;     // Reset state A
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        state <= next_state;
    end
end

always @(state or x or y) begin
    next_state = state;
    f = 1'b0;
    g = 1'b0;
    case (state)
        2'b00: begin   // State A
            if (!resetn) begin
                next_state = 2'b00;   // Remain in state A
            end else if (x) begin
                next_state = 2'b01;   // Transition to state B
            end
        end
        2'b01: begin   // State B
            if (!resetn) begin
                next_state = 2'b00;   // Reset to state A
            end else if (!x) begin
                f = 1'b1;
                next_state = 2'b10;   // Transition to state C
            end
        end
        2'b10: begin   // State C
            if (!resetn) begin
                next_state = 2'b00;   // Reset to state A
            end else if (x) begin
                next_state = 2'b11;   // Transition to state D
            end
        end
        2'b11: begin   // State D
            if (!resetn || !x) begin
                next_state = 2'b00;   // Reset to state A
            end else if (y) begin
                g = 1'b1;
                next_state = 2'b11;   // Remain in state D
            end else begin
                g = 1'b0;
                next_state = 2'b00;   // Reset to state A
            end
        end
    endcase
end

endmodule
