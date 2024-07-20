module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset to state 1
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    case (state)
        2'b00: begin
            if (train_valid) begin
                if (train_taken) begin
                    next_state = 2'b01; // Transition to state 1
                end
                else begin
                    next_state = 2'b00; // Remain in state 0
                end
            end
            else begin
                next_state = 2'b00; // Remain in state 0
            end
        end
        2'b01: begin
            if (train_valid) begin
                if (train_taken) begin
                    next_state = 2'b10; // Transition to state 2
                end
                else begin
                    next_state = 2'b00; // Transition to state 0
                end
            end
            else begin
                next_state = 2'b01; // Remain in state 1
            end
        end
        2'b10: begin
            if (train_valid) begin
                if (train_taken) begin
                    next_state = 2'b11; // Transition to state 3
                end
                else begin
                    next_state = 2'b01; // Transition to state 1
                end
            end
            else begin
                next_state = 2'b10; // Remain in state 2
            end
        end
        2'b11: begin
            if (train_valid) begin
                if (train_taken) begin
                    next_state = 2'b11; // Remain in state 3
                end
                else begin
                    next_state = 2'b10; // Transition to state 2
                end
            end
            else begin
                next_state = 2'b11; // Remain in state 3
            end
        end
        default: begin
            next_state = 2'b01; // Reset to state 1
        end
    endcase
end

endmodule
