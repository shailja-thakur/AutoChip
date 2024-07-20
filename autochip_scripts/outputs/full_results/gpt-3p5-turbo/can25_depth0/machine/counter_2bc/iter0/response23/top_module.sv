module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // Define the current state and next state variables
    logic [1:0] current_state;
    logic [1:0] next_state;

    // Flip-flops to store the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end

    // State transitions
    always_comb begin
        case (current_state)
            S0: begin
                if (train_valid && train_taken)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (train_valid && train_taken)
                    next_state = S2;
                else if (train_valid && !train_taken)
                    next_state = S0;
                else
                    next_state = S1;
            end
            S2: begin
                if (train_valid && train_taken)
                    next_state = S3;
                else if (train_valid && !train_taken)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S3: begin
                if (train_valid && !train_taken)
                    next_state = S2;
                else
                    next_state = S3;
            end
            default: next_state = S0; // Default state transition
        endcase
    end

    // Output
    assign state = current_state;

endmodule
