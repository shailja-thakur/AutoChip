module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam STATE0 = 2'b00;
    localparam STATE1 = 2'b01;
    localparam STATE2 = 2'b10;
    localparam STATE3 = 2'b11;
    
    // Define the state register
    logic [1:0] current_state;
    
    // Define the next state logic
    always_ff @(posedge clk or negedge areset) begin
        if (areset) begin
            current_state <= STATE1; // Reset to state 1
        end else begin
            case (current_state)
                STATE0: begin
                    if (train_valid && train_taken) begin
                        current_state <= STATE2; // Transition to state 2
                    end else begin
                        current_state <= STATE0; // Stay in state 0
                    end
                end
                STATE1: begin
                    if (train_valid && train_taken) begin
                        current_state <= STATE2; // Transition to state 2
                    end else begin
                        current_state <= STATE1; // Stay in state 1
                    end
                end
                STATE2: begin
                    if (train_valid && train_taken) begin
                        current_state <= STATE3; // Transition to state 3
                    end else begin
                        current_state <= STATE1; // Transition to state 1
                    end
                end
                STATE3: begin
                    if (train_valid && !train_taken) begin
                        current_state <= STATE2; // Transition to state 2
                    end else begin
                        current_state <= STATE3; // Stay in state 3
                    end
                end
                default: begin
                    current_state <= STATE1; // Default to state 1
                end
            endcase
        end
    end
    
    // Assign the current state to the output
    always_comb begin
        state = current_state;
    end
    
endmodule
