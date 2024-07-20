module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);
    // Define state variables
    logic [1:0] current_state, next_state;

    // Define state constants
    parameter IDLE = 0;
    parameter STATE1 = 1;
    parameter STATE2 = 2;
    parameter STATE3 = 3;

    // Synchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE1;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always @(current_state or train_valid or train_taken) begin
        case (current_state)
            IDLE: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE1; // Transition to state 1
                    end else begin
                        next_state <= IDLE; // No transition
                    end
                end else begin
                    next_state <= IDLE; // No transition
                end
            end

            STATE1: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE2; // Transition to state 2
                    end else begin
                        next_state <= IDLE; // Transition back to idle state
                    end
                end else begin
                    next_state <= STATE1; // No transition
                end
            end

            STATE2: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE3; // Transition to state 3
                    end else begin
                        next_state <= STATE1; // Transition back to state 1
                    end
                end else begin
                    next_state <= STATE2; // No transition
                end
            end

            STATE3: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE3; // No transition
                    end else begin
                        next_state <= STATE2; // Transition back to state 2
                    end
                end else begin
                    next_state <= STATE3; // No transition
                end
            end
        endcase
    end

    // Output assignment
    assign state = current_state;
    
endmodule
