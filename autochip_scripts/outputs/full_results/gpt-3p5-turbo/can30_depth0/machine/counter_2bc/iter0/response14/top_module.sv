module top_module(
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output logic [1:0] state
);
    // State signals
    logic [1:0] nextState;
    
    // Reset state to 1 when areset is asserted
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b01;
    end
    
    // State transitions based on train_valid and train_taken inputs
    always_ff @(posedge clk)
    begin
        if (train_valid)
        begin
            case (state)
                2'b00: nextState = train_taken ? 2'b01 : 2'b00;
                2'b01: nextState = train_taken ? 2'b10 : 2'b00;
                2'b10: nextState = train_taken ? 2'b11 : 2'b01;
                2'b11: nextState = train_taken ? 2'b11 : 2'b10;
            endcase
        end
        else
        begin
            nextState = state; // No transition
        end
    end
    
    // Synchronous state update
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b01;
        else
            state <= nextState;
    end
endmodule
