module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal registers
    reg [1:0] state_reg, state_next;

    // State encoding
    localparam STATE_0 = 2'b00,
               STATE_1 = 2'b01,
               STATE_2 = 2'b10,
               STATE_3 = 2'b11;

    // State transition logic
    always @(*) begin
        // Default state transition is to remain in the current state
        state_next = state_reg;
        
        if (train_valid) begin
            if (train_taken) begin
                if (state_reg < STATE_3)
                    state_next = state_reg + 1;
            end else begin
                if (state_reg > STATE_0)
                    state_next = state_reg - 1;
            end
        end
    end

    // State register logic with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state_reg <= STATE_1;
        else
            state_reg <= state_next;
    end

    // Output current state
    assign state = state_reg;

endmodule
