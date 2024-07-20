module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State parameter definitions
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;
    
    // State register
    reg [1:0] current_state;
    
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_1; // Reset to state 1
        end else if (train_valid) begin
            case (current_state)
                STATE_0: begin
                    // Transition to state 1 if train_taken is asserted
                    if (train_taken)
                        current_state <= STATE_1;
                end
                STATE_1: begin
                    // Transition to state 2 if train_taken is asserted
                    if (train_taken)
                        current_state <= STATE_2;
                    // Transition to state 0 if train_taken is not asserted
                    else
                        current_state <= STATE_0;
                end
                STATE_2: begin
                    // Transition to state 3 if train_taken is asserted
                    if (train_taken)
                        current_state <= STATE_3;
                    // Transition to state 1 if train_taken is not asserted
                    else
                        current_state <= STATE_1;
                end
                STATE_3: begin
                    // Transition to state 2 if train_taken is not asserted
                    if (!train_taken)
                        current_state <= STATE_2;
                end
                default: current_state <= STATE_1;
            endcase
        end
    end
    
    // Assign current_state to output state
    always @(current_state) begin
        state <= current_state;
    end
    
endmodule
