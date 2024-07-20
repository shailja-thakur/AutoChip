module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] next_state;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            next_state <= 2'b01;  // Reset to state 1
        end else if (train_valid) begin
            case (state)
                2'b00: begin  // Current state is 0
                    if (train_taken) begin
                        next_state <= 2'b01;  // Transition to state 1
                    end else begin
                        next_state <= 2'b00;  // No transition
                    end
                end
                2'b01: begin  // Current state is 1
                    if (train_taken) begin
                        if (state < 2'b11) begin
                            next_state <= state + 1;  // Transition to next state
                        else begin
                            next_state <= 2'b01;  // No transition
                        end
                    end else begin
                        if (state > 2'b00) begin
                            next_state <= state - 1;  // Transition to previous state
                        else begin
                            next_state <= 2'b01;  // No transition
                        end
                    end
                end
                2'b10: begin  // Current state is 2
                    if (train_taken) begin
                        if (state < 2'b11) begin
                            next_state <= state + 1;  // Transition to next state
                        else begin
                            next_state <= 2'b10;  // No transition
                        end
                    end else begin
                        if (state > 2'b00) begin
                            next_state <= state - 1;  // Transition to previous state
                        else begin
                            next_state <= 2'b10;  // No transition
                        end
                    end
                end
                2'b11: begin  // Current state is 3
                    if (train_taken) begin
                        next_state <= 2'b11;  // No transition
                    end else begin
                        if (state > 2'b00) begin
                            next_state <= state - 1;  // Transition to previous state
                        else begin
                            next_state <= 2'b11;  // No transition
                        end
                    end
                end
            endcase
        end else begin
            next_state <= state;  // No transition
        end
    end

    assign state = next_state;
endmodule
