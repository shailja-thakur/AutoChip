module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    typedef enum logic [1:0] {
        S0 = 2'd0,
        S1 = 2'd1,
        S2 = 2'd2,
        S3 = 2'd3
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state; // default to no state change
        if (train_valid) begin
            case (current_state)
                S0: if (train_taken) next_state = S1;
                S1: if (train_taken) next_state = S2; else if (!train_taken) next_state = S0;
                S2: if (train_taken) next_state = S3; else if (!train_taken) next_state = S1;
                S3: if (!train_taken) next_state = S2;
            endcase
        end
    end

    assign state = current_state;
    
endmodule
