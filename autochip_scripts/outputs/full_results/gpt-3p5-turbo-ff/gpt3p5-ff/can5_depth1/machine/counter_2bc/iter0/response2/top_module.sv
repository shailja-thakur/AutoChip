module top_module (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    /////////////////////////////
    // State Machine Definition //
    /////////////////////////////
    
    typedef enum logic [1:0] {
        S0, S1, S2, S3
    } state_type;
    
    state_type current_state, next_state;
    
    /////////////////////////
    // State Transitioning //
    /////////////////////////
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            current_state <= next_state;
        end
    end
    
    always_comb begin
        case (current_state)
            S0: begin
                if (train_taken && current_state < S3) begin
                    next_state = S1;
                end else begin
                    next_state = current_state;
                end
            end
            
            S1: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state = S2;
                    end else begin
                        next_state = S0;
                    end
                end else begin
                    next_state = S1;
                end
            end
            
            S2: begin
                if (train_taken) begin
                    next_state = S3;
                end else begin
                    next_state = S1;
                end
            end
            
            S3: begin
                if (!train_taken && current_state > S0) begin
                    next_state = S2;
                end else begin
                    next_state = current_state;
                end
            end
        endcase
    end
    
    ////////////
    // Output //
    ////////////
    
    assign state = current_state;
    
endmodule
