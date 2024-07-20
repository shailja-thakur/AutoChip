module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg f, g;
reg [2:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 3'b000; // state A
        f <= 0;
        g <= 0;
    end else begin
        state <= next_state;
        f <= 1'b0; // Set f to 1 for one clock cycle
        case (state)
            3'b000: begin // State A
                if (x == 1'b1)
                    next_state <= 3'b001; // Transition to State B
                else
                    next_state <= state; // Stay in State A
            end
            3'b001: begin // State B
                if (x == 1'b0)
                    next_state <= 3'b010; // Transition to State C
                else
                    next_state <= state; // Stay in State B
            end
            3'b010: begin // State C
                if (x == 1'b1)
                    next_state <= 3'b011; // Transition to State D
                else
                    next_state <= state; // Stay in State C
            end
            3'b011: begin // State D
                if (g == 1'b1)
                    next_state <= 3'b100; // Transition to State E
                else
                    next_state <= state; // Stay in State D
            end
            3'b100: begin // State E
                if (y == 1'b1)
                    next_state <= 3'b100; // Stay in State E
                else
                    next_state <= 3'b101; // Transition to State F
            end
            3'b101: begin // State F
                next_state <= 3'b000; // Transition to State A
            end
        endcase
    end
end

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        g <= 0;
    else
        case (state)
            3'b000: g <= 0; // State A
            3'b100: g <= 1; // State E
            default: g <= g; // Stay in current state
        endcase
end

endmodule
