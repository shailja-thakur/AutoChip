module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
reg [2:0] x_history;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;     // Reset state A
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        case (state)
            2'b00: begin   // State A
                f <= 1'b0;
                g <= 1'b0;
                if (x) begin
                    state <= 2'b01;   // Transition to state B
                end
            end
            2'b01: begin   // State B
                f <= 1'b1;
                g <= 1'b0;
                if (!x) begin
                    state <= 2'b10;   // Transition to state C
                end
            end
            2'b10: begin   // State C
                f <= 1'b0;
                if (x) begin
                    state <= 2'b11;   // Transition to state D
                end
            end
            2'b11: begin   // State D
                if (x) begin
                    g <= 1'b1;
                    if (y) begin
                        state <= 2'b11;   // Remain in state D
                    end else begin
                        state <= 2'b00;   // Reset to state A
                    end
                end else if (!x && x_history === 3'b101) begin
                    g <= 1'b1;
                    state <= 2'b11;   // Remain in state D
                end else begin
                    state <= 2'b01;   // Transition to state B
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (!resetn) begin
        x_history <= 3'b000;
    end else begin
        x_history <= {x_history[1:0], x};
    end
end

endmodule
