module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        S4,
        S5,
        ERROR
    } state_t;
    
    state_t state, next_state;

    // Register to hold the previous input value
    reg prev_input;

    // Output registers
    reg disc_reg, flag_reg, err_reg;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            prev_input <= 0;
            disc_reg <= 0;
            flag_reg <= 0;
            err_reg <= 0;
        end else begin
            state <= next_state;
            prev_input <= in;
            disc_reg <= 0;
            flag_reg <= 0;
            err_reg <= 0;
            case(state)
                // IDLE state
                IDLE: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                    end else if (prev_input == 0 && in == 1) begin
                        next_state <= S1;
                    end
                end
                // S1 state
                S1: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                        disc_reg <= 1;
                    end else if (in == 1) begin
                        next_state <= S2;
                    end
                end
                // S2 state
                S2: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                        flag_reg <= 1;
                    end else if (in == 1) begin
                        next_state <= S3;
                    end
                end
                // S3 state
                S3: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                        disc_reg <= 1;
                    end else if (in == 1) begin
                        next_state <= S4;
                    end
                end
                // S4 state
                S4: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                        disc_reg <= 1;
                    end else if (in == 1) begin
                        next_state <= S5;
                    end
                end
                // S5 state
                S5: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                        disc_reg <= 1;
                    end else if (in == 1) begin
                        next_state <= ERROR;
                        err_reg <= 1;
                    end
                end
                // ERROR state
                ERROR: begin
                    if (in == 0) begin
                        next_state <= IDLE;
                    end else if (in == 1) begin
                        next_state <= ERROR;
                    end
                end
            endcase
        end
    end

    // Output assignments
    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err = err_reg;

endmodule
