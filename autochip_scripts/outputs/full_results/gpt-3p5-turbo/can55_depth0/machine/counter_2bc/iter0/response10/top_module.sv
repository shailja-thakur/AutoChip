module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output logic [1:0] state
);

    // Define the four states
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_type;

    // Register to hold the current state
    reg state_type current_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            current_state <= STATE_1;
        end else begin
            // State transitions based on train_valid and train_taken signals
            if (train_valid) begin
                case (current_state)
                    STATE_0: begin
                        if (train_taken) begin
                            current_state <= STATE_1;
                        end
                    end

                    STATE_1: begin
                        if (train_taken) begin
                            current_state <= STATE_2;
                        end else begin
                            current_state <= STATE_0;
                        end
                    end

                    STATE_2: begin
                        if (train_taken) begin
                            current_state <= STATE_3;
                        end else begin
                            current_state <= STATE_1;
                        end
                    end

                    STATE_3: begin
                        if (!train_taken) begin
                            current_state <= STATE_2;
                        end
                    end

                    default: begin
                        current_state <= STATE_1;
                    end
                endcase
            end
        end
    end

    // Assign current_state to output state
    assign state = current_state;

endmodule
