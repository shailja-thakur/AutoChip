module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1;
        else begin
            case (state)
                0: begin
                    if (train_taken && (state < 3))
                        next_state <= state + 1;
                    else
                        next_state <= state;
                end
                1: begin
                    if (train_taken && (state < 3))
                        next_state <= state + 1;
                    else if (!train_taken && (state > 0))
                        next_state <= state - 1;
                    else
                        next_state <= state;
                end
                2: begin
                    if (train_taken && (state < 3))
                        next_state <= state + 1;
                    else if (!train_taken && (state > 0))
                        next_state <= state - 1;
                    else
                        next_state <= state;
                end
                3: begin
                    if (!train_taken && (state > 0))
                        next_state <= state - 1;
                    else
                        next_state <= state;
                end
                default: next_state <= 1;
            endcase
            state <= next_state;
        end
    end

endmodule
