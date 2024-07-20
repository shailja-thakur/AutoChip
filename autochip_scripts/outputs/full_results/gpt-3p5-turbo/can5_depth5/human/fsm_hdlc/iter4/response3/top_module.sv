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
        S4,
        ERROR
    } state_t;
    
    state_t state, next_state;

    // Testbench variables
    reg prev_input;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
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
                    if (prev_input == 1 & in == 1) begin
                        next_state <= S1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                // S1 state
                S1: begin
                    if (in == 1) begin
                        next_state <= S2;
                    end else begin
                        next_state <= IDLE;
                        disc <= 1;
                    end
                end
                // S2 state
                S2: begin
                    if (in == 1) begin
                        next_state <= S3;
                    end else begin
                        next_state <= IDLE;
                        flag <= 1;
                    end
                end
                // S3 state
                S3: begin
                    if (in == 1) begin
                        next_state <= S4;
                    end else begin
                        next_state <= IDLE;
                        disc <= 1;
                    end
                end
                // S4 state
                S4: begin
                    if (in == 1) begin
                        next_state <= ERROR;
                    end else begin
                        next_state <= IDLE;
                        disc <= 1;
                    end
                end
                // ERROR state
                ERROR: begin
                    if (in == 1) begin
                        next_state <= ERROR;
                    end else begin
                        next_state <= IDLE;
                        disc <= 0;
                        err <= 1;
                    end
                end
            endcase
        end
    end

endmodule
