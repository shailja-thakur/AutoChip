module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal signals
    logic [1:0] next_state;

    // Declare initial state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;
        else 
            state <= next_state;
    end

    // Declare next state logic
    always_comb begin
        case (state)
            2'b00: begin
                if (train_valid && train_taken)
                    next_state = 2'b01;
                else if (train_valid)
                    next_state = 2'b00;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (train_valid && train_taken)
                    next_state = 2'b10;
                else if (train_valid)
                    next_state = 2'b00;
                else
                    next_state = 2'b01;
            end
            2'b10: begin
                if (train_valid && train_taken)
                    next_state = 2'b11;
                else if (train_valid)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
            end
            2'b11: begin
                if (train_valid && train_taken)
                    next_state = 2'b11;
                else if (train_valid)
                    next_state = 2'b10;
                else
                    next_state = 2'b11;
            end
            default: next_state = 2'b00;
        endcase
    end

    // Assign next state to current state
    always_ff @(posedge clk) begin
        state <= next_state;
    end

endmodule
