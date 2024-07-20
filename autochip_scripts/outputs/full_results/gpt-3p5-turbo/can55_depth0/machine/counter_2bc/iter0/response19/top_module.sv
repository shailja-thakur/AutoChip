module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    parameter STATE_2 = 2'b10;
    parameter STATE_3 = 2'b11;
    
    // Define the state register
    logic [1:0] state_reg;
    
    // Reset the state register on asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_reg <= STATE_1;
        end else begin
            state_reg <= state_reg; // No change to state register
        end
    end
    
    // Update the state based on inputs
    always_comb begin
        case (state_reg)
            STATE_0: begin
                if (train_valid) begin
                    if (train_taken) begin
                        state = STATE_1;
                    end else begin
                        state = STATE_0;
                    end
                end
            end
            STATE_1: begin
                if (train_valid) begin
                    if (train_taken) begin
                        state = STATE_2;
                    end else begin
                        state = STATE_0;
                    end
                end
            end
            STATE_2: begin
                if (train_valid) begin
                    if (train_taken) begin
                        state = STATE_3;
                    end else begin
                        state = STATE_1;
                    end
                end
            end
            STATE_3: begin
                if (train_valid) begin
                    if (!train_taken) begin
                        state = STATE_2;
                    end else begin
                        state = STATE_3;
                    end
                end
            end
        endcase
    end
    
endmodule
