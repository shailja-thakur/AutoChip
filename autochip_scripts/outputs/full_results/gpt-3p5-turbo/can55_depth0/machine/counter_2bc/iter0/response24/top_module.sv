module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam IDLE = 0;
    localparam STATE1 = 1;
    localparam STATE2 = 2;
    localparam STATE3 = 3;

    // Define the state register
    logic [1:0] state_reg;

    // Define the next state
    logic [1:0] next_state;

    // Register the inputs
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            state_reg <= STATE1;
        else
            state_reg <= next_state;
    end

    // Determine the next state based on the current state and inputs
    always_comb
    begin
        case (state_reg)
            IDLE: begin
                if (train_valid)
                begin
                    if (train_taken)
                        next_state = STATE1;
                    else
                        next_state = IDLE;
                end
                else
                    next_state = IDLE;
            end
            STATE1: begin
                if (train_valid)
                begin
                    if (train_taken)
                        next_state = STATE2;
                    else
                        next_state = IDLE;
                end
                else if (train_taken)
                    next_state = STATE3;
                else
                    next_state = STATE1;
            end
            STATE2: begin
                if (train_valid)
                begin
                    if (train_taken)
                        next_state = STATE3;
                    else
                        next_state = STATE1;
                end
                else if (train_taken)
                    next_state = IDLE;
                else
                    next_state = STATE2;
            end
            STATE3: begin
                if (train_valid)
                begin
                    if (train_taken)
                        next_state = STATE3;
                    else
                        next_state = STATE2;
                end
                else
                    next_state = STATE3;
            end
            default: next_state = IDLE;
        endcase
    end

    // Assign the output
    assign state = state_reg;

endmodule
