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
    reg prev_input;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case(state)
            // IDLE state
            IDLE: begin
                disc = 0;
                flag = 0;
                err = 0;
                if (in == 1 & prev_input == 1) begin
                    next_state = S1;
                end
                else begin
                    next_state = IDLE;
                end
            end
            
            // S1 state
            S1: begin
                if (in == 1) begin
                    next_state = S2;
                    disc = 0;
                    flag = 0;
                    err = 0;
                end
                else begin
                    next_state = IDLE;
                    disc = 1;
                end
            end
            
            // S2 state
            S2: begin
                if (in == 1) begin
                    next_state = S3;
                    disc = 0;
                    flag = 0;
                    err = 0;
                end
                else begin
                    next_state = IDLE;
                    flag = 1;
                end
            end
            
            // S3 state
            S3: begin
                if (in == 1) begin
                    next_state = S4;
                    disc = 0;
                    flag = 0;
                    err = 0;
                end
                else begin
                    next_state = IDLE;
                    disc = 1;
                end
            end
            
            // S4 state
            S4: begin
                if (in == 1) begin
                    next_state = S5;
                    disc = 0;
                    flag = 0;
                    err = 0;
                end
                else begin
                    next_state = IDLE;
                    disc = 1;
                end
            end
            
            // S5 state
            S5: begin
                if (in == 1) begin
                    next_state = ERROR;
                    disc = 0;
                    flag = 0;
                    err = 1;
                end
                else begin
                    next_state = IDLE;
                    disc = 1;
                end
            end
            
            // ERROR state
            ERROR: begin
                if (in == 1) begin
                    next_state = ERROR;
                end
                else begin
                    next_state = IDLE;
                    disc = 0;
                    flag = 0;
                    err = 0;
                end
            end
        endcase
        
        prev_input = in;
    end

endmodule
