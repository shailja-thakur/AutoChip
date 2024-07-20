module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    typedef enum logic [1:0] {
        WK_NOT_TAKEN = 2'b01,
        WK_TAKEN = 2'b10,
        ST_TAKEN = 2'b11,
        ST_NOT_TAKEN = 2'b00
    } state_t;

    state_t current_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WK_NOT_TAKEN; // reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (current_state < ST_TAKEN) begin
                    current_state <= current_state + 2'b01;
                end
            end else begin
                if (current_state > ST_NOT_TAKEN) begin
                    current_state <= current_state - 2'b01;
                end
            end
        end
    end

    assign state = current_state;

endmodule
