module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] next_state;
    
    // State register
    always_ff @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            state <= 2'b01;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case (state)
            2'b00: begin
                if (train_taken && train_valid && state < 2'b11) begin
                    next_state = state + 1;
                end else begin
                    next_state = state;
                end
            end
            2'b01: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state = 2'b10;
                    end else begin
                        next_state = 2'b00;
                    end
                end else begin
                    next_state = state;
                end
            end
            2'b10: begin
                if (train_valid && state > 2'b00) begin
                    next_state = state - 1;
                end else begin
                    next_state = state;
                end
            end
            2'b11: begin
                if (train_valid) begin
                    next_state = state;  // No further transitions
                end else begin
                    next_state = 2'b01;
                end
            end
            default: next_state = 2'b01;
        endcase
    end

endmodule
