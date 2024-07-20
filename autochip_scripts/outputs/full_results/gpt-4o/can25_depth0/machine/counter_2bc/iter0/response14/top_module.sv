module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// State encoding
localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

logic [1:0] next_state;

// Sequential logic for state transition and asynchronous reset
always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= S1;
    else
        state <= next_state;
end

// Combinational logic for next state determination
always_comb begin
    next_state = state; // Default to current state
    if (train_valid) begin
        if (train_taken) begin
            if (state < S3)
                next_state = state + 2'b01;
        end else begin
            if (state > S0)
                next_state = state - 2'b01;
        end
    end
end

endmodule
