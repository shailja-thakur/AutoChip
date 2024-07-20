module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [2:0] {IDLE, START, DATA, STOP, ERROR} state_t;
    state_t state, next_state;
    
    reg [2:0] bit_count;  // To count the 8 data bits
    reg [7:0] data;  // Storage for the received 8 data bits

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: 
                if (in == 0)
                    next_state = START;
                else
                    next_state = IDLE;
            START:
                next_state = DATA;
            DATA:
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            STOP:
                if (in == 1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            ERROR:
                if (in == 1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and data sampling
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            data <= 8'd0;
            done <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    bit_count <= 3'd0;
                end
                START: begin
                    // do nothing, just transition
                end
                DATA: begin
                    data[bit_count] <= in;
                    bit_count <= bit_count + 3'd1;
                end
                STOP: begin
                    if (in == 1) begin
                        done <= 1;
                    end
                    else begin
                        done <= 0;
                    end
                end
                ERROR: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
