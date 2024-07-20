module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;
    
    state_t state_reg, state_next;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state_reg <= STATE_1; 
        end else begin
            state_reg <= state_next;
        end
    end
    
    always_comb begin
        state_next = state_reg; // Default state (remains the same)
        if (train_valid) begin
            if (train_taken && state_reg < STATE_3) begin
                state_next = state_reg + 1;
            end else if (!train_taken && state_reg > STATE_0) begin
                state_next = state_reg - 1;
            end
        end
    end
    
    assign state = state_reg;

endmodule
