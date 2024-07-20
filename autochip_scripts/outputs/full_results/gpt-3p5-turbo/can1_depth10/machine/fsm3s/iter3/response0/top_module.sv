module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Initial state A
    end else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        2'b00: begin // State A
            if (in) begin
                next_state = 2'b01; // Transition to state B
            end else begin
                next_state = 2'b00; // Remain in state A
            end
        end
        2'b01: begin // State B
            if (in) begin
                next_state = 2'b10; // Transition to state C
            end else begin
                next_state = 2'b00; // Transition to state A
            end
        end
        2'b10: begin // State C
            if (in) begin
                next_state = 2'b11; // Transition to state D
            end else begin
                next_state = 2'b00; // Transition to state A
            end
        end
        2'b11: begin // State D
            if (in) begin
                next_state = 2'b01; // Transition to state B
            end else begin
                next_state = 2'b10; // Transition to state C
            end
        end
    endcase
end

always @(posedge clk) begin
    if (state == 2'b11) begin // State D
        out <= 1;
    end else begin
        out <= 0;
    end
end

endmodule
