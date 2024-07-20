module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state registers
    logic [1:0] cur_state, next_state;
    
    // State definitions
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            cur_state <= STATE_1; // Asynchronous reset to state 1
        else
            cur_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = cur_state; // Default to no state change
        if (train_valid) begin
            if (train_taken) begin
                if (cur_state < STATE_3)
                    next_state = cur_state + 1;
            end else begin
                if (cur_state > STATE_0)
                    next_state = cur_state - 1;
            end
        end
    end

    // Output logic
    assign state = cur_state;

endmodule
