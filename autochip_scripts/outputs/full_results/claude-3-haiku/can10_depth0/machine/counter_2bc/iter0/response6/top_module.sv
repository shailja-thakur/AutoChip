module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset to state 1
    end
    else if (train_valid) begin
        state <= next_state;
    end
end

always_comb begin
    case (state)
        2'b00: begin // State 0
            if (train_taken) begin
                next_state = 2'b01; // Transition to state 1
            end
            else begin
                next_state = 2'b00; // Stay in state 0
            end
        end
        2'b01: begin // State 1
            if (train_taken) begin
                next_state = 2'b10; // Transition to state 2
            end
            else begin
                next_state = 2'b00; // Transition to state 0
            end
        end
        2'b10: begin // State 2
            if (train_taken) begin
                next_state = 2'b11; // Transition to state 3
            end
            else begin
                next_state = 2'b01; // Transition to state 1
            end
        end
        2'b11: begin // State 3
            if (train_taken) begin
                next_state = 2'b11; // Stay in state 3
            end
            else begin
                next_state = 2'b10; // Transition to state 2
            end
        end
        default: begin
            next_state = 2'b01; // Reset to state 1 for any invalid state
        end
    endcase
end

endmodule
