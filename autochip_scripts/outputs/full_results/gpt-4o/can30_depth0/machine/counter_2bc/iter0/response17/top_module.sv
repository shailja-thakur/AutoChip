module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state update
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1;
        end 
        else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        next_state = current_state;
        if (train_valid) begin
            case (current_state)
                S0: begin
                    if (train_taken) next_state = S1;
                end
                S1: begin
                    if (train_taken) next_state = S2;
                    else next_state = S0;
                end
                S2: begin
                    if (train_taken) next_state = S3;
                    else next_state = S1;
                end
                S3: begin
                    if (!train_taken) next_state = S2;
                end
            endcase
        end
    end

    // Output state assignment
    assign state = current_state;

endmodule
