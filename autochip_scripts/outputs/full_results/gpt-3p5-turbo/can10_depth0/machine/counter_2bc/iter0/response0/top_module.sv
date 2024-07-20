module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            case ({train_valid, train_taken})
                2'b10: begin
                    if (state < 2'b11) begin
                        next_state = state + 1;
                    end else begin
                        next_state = state;
                    end
                end

                2'b01: begin
                    if (state > 2'b00) begin
                        next_state = state - 1;
                    end else begin
                        next_state = state;
                    end
                end

                default: begin
                    next_state = state;
                end
            endcase

            state <= next_state;
        end
    end

endmodule
