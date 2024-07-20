module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // State definitions
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    
    // Registers for state machine
    reg [1:0] current_state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(train_valid, train_taken) begin
        case (current_state)
            S0: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state = S1;
                    end else begin
                        next_state = S0;
                    end
                end else begin
                    next_state = S0;
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
                if (train_valid) begin
                    if (train_taken) begin
                        next_state = S3;
                    end else begin
                        next_state = S1;
                    end
                end else begin
                    next_state = S2;
                end
            end
            
            S3: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state = S3;
                    end else begin
                        next_state = S2;
                    end
                end else begin
                    next_state = S3;
                end
            end
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end
endmodule
