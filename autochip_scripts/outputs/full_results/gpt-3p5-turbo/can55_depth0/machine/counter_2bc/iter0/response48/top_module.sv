module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the internal signals
    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1;
        end else if (train_valid) begin
            if (train_taken && (state < 3)) begin
                next_state <= state + 1;
            end else if (!train_taken && (state > 0)) begin
                next_state <= state - 1;
            end else begin
                next_state <= state;
            end
        end
    end

    always_comb begin
        state <= next_state;
    end

endmodule
