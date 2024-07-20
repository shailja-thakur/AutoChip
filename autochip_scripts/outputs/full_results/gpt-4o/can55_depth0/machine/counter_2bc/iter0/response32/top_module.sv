module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // Define state parameters for better readability
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // State register
    reg [1:0] next_state;

    // Asynchronous reset and state update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S1;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to hold state
        if (train_valid) begin
            if (train_taken) begin
                if (state < S3)
                    next_state = state + 1;
            end else begin
                if (state > S0)
                    next_state = state - 1;
            end
        end
    end
endmodule
