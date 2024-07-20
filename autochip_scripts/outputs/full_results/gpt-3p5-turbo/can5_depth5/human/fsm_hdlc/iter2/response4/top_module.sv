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
        S5,
        ERROR
    } state_t;
    
    state_t state, next_state;

    // Register to hold the previous input value
    reg prev_input;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;
            prev_input <= in;
        end
    end

    always @(*) begin
        disc <= 0;
        flag <= 0;
        err <= 0;
        case(state)
            // IDLE state
            IDLE: begin
                if (in == 0) begin
                    next_state = IDLE;
                end else if (prev_input == 1 & in == 1) begin
                    next_state = S1;
                end
            end
            // S1 state
            S1: begin
                if (in == 0) begin
                    next_state = IDLE;
                    disc = 1;
                end else if (in == 1) begin
                    next_state = S2;
                end
            end
            // S2 state
            S2: begin
                if (in == 0) begin
                    next_state = IDLE;
                    flag = 1;
                end else if (in == 1) begin
                    next_state = S3;
                end
            end
            // S3 state
            S3: begin
                if (in == 0) begin
                    next_state = IDLE;
                    disc = 1;
                end else if (in == 1) begin
                    next_state = S4;
                end
            end
            // S4 state
            S4: begin
                if (in == 0) begin
                    next_state = IDLE;
                    disc = 1;
                end else if (in == 1) begin
                    next_state = S5;
                end
            end
            // S5 state
            S5: begin
                if (in == 0) begin
                    next_state = IDLE;
                    disc = 1;
                end else if (in == 1) begin
                    next_state = ERROR;
                    err = 1;
                end
            end
            // ERROR state
            ERROR: begin
                if (in == 0) begin
                    next_state = IDLE;
                end else if (in == 1) begin
                    next_state = ERROR;
                end
            end
        endcase
    end

endmodule
