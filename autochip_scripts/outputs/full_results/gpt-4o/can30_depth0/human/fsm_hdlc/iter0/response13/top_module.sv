module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // Define state codes
    typedef enum logic[2:0] {
        IDLE        = 3'b000,
        ONE         = 3'b001,
        TWO         = 3'b010,
        THREE       = 3'b011,
        FOUR        = 3'b100,
        FIVE        = 3'b101,
        SIX         = 3'b110,
        SEVEN       = 3'b111
    } state_t;
    
    state_t state, next_state;

    // State update logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always @(*) begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            IDLE: begin
                if (in)
                    next_state = ONE;
                else
                    next_state = IDLE;
            end

            ONE: begin
                if (in)
                    next_state = TWO;
                else
                    next_state = IDLE;
            end

            TWO: begin
                if (in)
                    next_state = THREE;
                else
                    next_state = IDLE;
            end

            THREE: begin
                if (in)
                    next_state = FOUR;
                else
                    next_state = IDLE;
            end

            FOUR: begin
                if (in)
                    next_state = FIVE;
                else
                    next_state = IDLE;
            end

            FIVE: begin
                if (in)
                    next_state = SIX;
                else begin
                    disc = 1;
                    next_state = IDLE;
                end
            end

            SIX: begin
                if (in)
                    next_state = SEVEN;
                else begin
                    flag = 1;
                    next_state = IDLE;
                end
            end

            SEVEN: begin
                if (in) begin
                    err = 1;
                    next_state = SEVEN; // Remain in error state
                end else begin
                    flag = 1;
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Outputs are registered to maintain them for one full clock cycle
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            case (next_state)
                IDLE: begin
                    disc <= disc;
                    flag <= flag;
                    err <= err;
                end
                ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN: begin
                    disc <= (next_state == IDLE) && (state == FIVE);
                    flag <= ((next_state == IDLE) && (state == SIX)) || ((next_state == IDLE) && (state == SEVEN));
                    err <= (state == SEVEN) && in;
                end
                default: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            endcase
        end
    end
endmodule
