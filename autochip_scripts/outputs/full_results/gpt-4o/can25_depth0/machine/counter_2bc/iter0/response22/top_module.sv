module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define states
    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
    always_comb begin
        case (current_state)
            STATE_0: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = STATE_1;
                    else
                        next_state = STATE_0;
                end else begin
                    next_state = STATE_0;
                end
            end
            
            STATE_1: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = STATE_2;
                    else
                        next_state = STATE_0;
                end else begin
                    next_state = STATE_1;
                end
            end
            
            STATE_2: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = STATE_3;
                    else
                        next_state = STATE_1;
                end else begin
                    next_state = STATE_2;
                end
            end
            
            STATE_3: begin
                if (train_valid) begin
                    if (train_taken)
                        next_state = STATE_3;
                    else
                        next_state = STATE_2;
                end else begin
                    next_state = STATE_3;
                end
            end
            
            default: next_state = STATE_1;
        endcase
    end
    
    // State register logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Output logic
    assign state = current_state;
    
endmodule
