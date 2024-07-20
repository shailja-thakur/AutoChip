module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // Define states
    typedef enum logic [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        ERROR
    } state_t;
    
    state_t state, next_state;

    // Register to hold the previous input value
    reg prev_input;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            prev_input <= 0;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end
        else begin
            state <= next_state;
            prev_input <= in;

            case(state)
                // IDLE state
                IDLE: begin
                    if (in == 1 && prev_input == 1) begin
                        next_state <= S1;
                    end else begin
                        next_state <= IDLE;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                // S1 state
                S1: begin
                    if (in == 1) begin
                        next_state <= S2;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end else begin
                        next_state <= IDLE;
                        disc <= 1;
                        flag <= 0;
                        err <= 0;
                    end
                end
                // S2 state
                S2: begin
                    if (in == 1) begin
                        next_state <= S3;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end else begin
                        next_state <= IDLE;
                        disc <= 0;
                        flag <= 1;
                        err <= 0;
                    end
                end
                // S3 state
                S3: begin
                    if (in == 1) begin
                        next_state <= ERROR;
                        disc <= 0;
                        flag <= 0;
                        err <= 1;
                    end else begin
                        next_state <= IDLE;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                // ERROR state
                ERROR: begin
                    if (in == 1) begin
                        next_state <= ERROR;
                    end else begin
                        next_state <= IDLE;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
            endcase
        end
    end

endmodule
