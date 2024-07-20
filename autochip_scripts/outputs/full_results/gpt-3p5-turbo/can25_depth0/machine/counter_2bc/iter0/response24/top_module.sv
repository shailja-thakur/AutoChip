module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // State declaration
    logic [1:0] current_state, next_state;
    
    // State values
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    
    // State machine logic
    always_ff @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            current_state <= S1; // Reset to state S1
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            S0: begin
                if (train_valid) begin
                    if (train_taken && current_state < S3) begin
                        next_state = S1;
                    end else begin
                        next_state = current_state;
                    end
                end else begin
                    next_state = current_state;
                end
            end
            
            S1: begin
                if (train_valid) begin
                    if (train_taken && current_state < S3) begin
                        next_state = S2;
                    end else begin
                        next_state = S0;
                    end
                end else begin
                    next_state = current_state;
                end
            end
            
            S2: begin
                if (train_valid) begin
                    if (train_taken && current_state < S3) begin
                        next_state = S3;
                    end else begin
                        next_state = S1;
                    end
                end else begin
                    next_state = current_state;
                end
            end
            
            S3: begin
                if (train_valid) begin
                    if (!train_taken && current_state > S0) begin
                        next_state = S2;
                    end else begin
                        next_state = S3;
                    end
                end else begin
                    next_state = current_state;
                end
            end
            
            default: begin
                next_state = current_state;
            end
        endcase
    end
    
    // Output assignment
    assign state = current_state;
    
endmodule
