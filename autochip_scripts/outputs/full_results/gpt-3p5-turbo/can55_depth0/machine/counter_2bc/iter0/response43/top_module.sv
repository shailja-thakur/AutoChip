module top_module (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Registers to hold the current state and next state
    logic [1:0] curr_state;
    logic [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            curr_state <= 2'b01;
        end else begin
            // Transition logic based on train_valid and train_taken signals
            case (curr_state)
                2'b00: begin
                    // State 0
                    if (train_valid && train_taken) begin
                        next_state <= 2'b01;
                    end else begin
                        next_state <= 2'b00;
                    end
                end

                2'b01: begin
                    // State 1
                    if (train_valid && train_taken) begin
                        next_state <= 2'b10;
                    end else if (!train_valid && curr_state > 2'b00) begin
                        next_state <= 2'b00;
                    end else begin
                        next_state <= 2'b01;
                    end
                end

                2'b10: begin
                    // State 2
                    if (!train_valid && curr_state > 2'b00) begin
                        next_state <= 2'b01;
                    end else if (train_valid && !train_taken) begin
                        next_state <= 2'b01;
                    end else if (train_valid && train_taken) begin
                        next_state <= 2'b11;
                    end else begin
                        next_state <= 2'b10;
                    end
                end

                2'b11: begin
                    // State 3
                    if (!train_valid && curr_state > 2'b00) begin
                        next_state <= 2'b10;
                    end else if (train_valid && !train_taken) begin
                        next_state <= 2'b10;
                    end else begin
                        next_state <= 2'b11;
                    end
                end

                default: begin
                    // Default to state 1
                    next_state <= 2'b01;
                end
            endcase
        end
    end

    // Assign next_state to curr_state at the end of each clock cycle
    always @(posedge clk) begin
        curr_state <= next_state;
    end

    assign state = curr_state;

endmodule
