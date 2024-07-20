module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        ONE_0 = 3'd1,
        SIX_1s = 3'd2,
        WAIT_DISC = 3'd3,
        WAIT_FLAG = 3'd4,
        ERROR = 3'd5
    } state_t;
        
    state_t state, next_state;
    integer count;

    // State transition and output logic
    always @(*) begin
        next_state = state;
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            IDLE: begin
                if (in == 1'b1)
                    next_state = ONE_0;
            end

            ONE_0: begin
                if (in == 1'b1)
                    next_state = SIX_1s;
                else
                    next_state = IDLE;
            end

            SIX_1s: begin
                if (in == 1'b1)
                    count = count + 1;
                else if (count == 5) begin
                    disc = 1;
                    next_state = WAIT_DISC;
                end
                else if (count == 6) begin
                    flag = 1;
                    next_state = WAIT_FLAG;
                end
                else begin
                    count = 0;
                    next_state = IDLE;
                end

                if (count >= 7) begin
                    err = 1;
                    next_state = ERROR;
                end
            end

            WAIT_DISC: begin
                if (in == 0) 
                    next_state = IDLE;
                else if (count >= 5) 
                    next_state = SIX_1s;
            end

            WAIT_FLAG: begin
                if (in == 0)
                    next_state = IDLE;
                else if (count >= 6)
                    next_state = SIX_1s;
            end

            ERROR: begin
                err = 1;
                next_state = state;
            end
        endcase
    end

    // State and counter update
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
        end
        else begin
            state <= next_state;
            if (state == SIX_1s && in == 1'b1)
                count <= count + 1;
            else if (state == SIX_1s && in == 1'b0)
                count <= 0;
        end
    end

endmodule
