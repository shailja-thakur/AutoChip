module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum reg [2:0]
    {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        ERROR
    } state_t;
    
    state_t state, next_state;
    reg [2:0] data_count;

    always @ (posedge clk or posedge reset)
    begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @ (*)
    begin
        next_state = state;
        done = 0;
        case (state)
            IDLE:
                if (in == 0)
                    next_state = START_BIT;
            START_BIT:
                next_state = DATA_BITS;
            DATA_BITS:
                if (data_count == 7)
                    next_state = STOP_BIT;
            STOP_BIT:
                if (in == 1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            ERROR:
                if (in == 1)
                    next_state = IDLE;
        endcase
    end

    always @ (posedge clk)
    begin
        if (reset) begin
            data_count <= 0;
        end else begin
            case (state)
                DATA_BITS:
                    data_count <= data_count + 1;
                default:
                    data_count <= 0;
            endcase

            if (state == STOP_BIT && in == 1)
                done <= 1;
        end
    end

endmodule
