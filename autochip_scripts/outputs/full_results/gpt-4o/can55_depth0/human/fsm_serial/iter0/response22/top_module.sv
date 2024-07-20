module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE    = 4'b0000,
        START   = 4'b0001,
        DATA0   = 4'b0010,
        DATA1   = 4'b0011,
        DATA2   = 4'b0100,
        DATA3   = 4'b0101,
        DATA4   = 4'b0110,
        DATA5   = 4'b0111,
        DATA6   = 4'b1000,
        DATA7   = 4'b1001,
        STOP    = 4'b1010
    } state_t;

    state_t current_state, next_state;
    reg [7:0] data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;  // Default assignment
        done = 0;                    // Default assignment
        
        case (current_state)
            IDLE: begin
                if (in == 0) begin // Looking for start bit
                    next_state = START;
                end
            end
            
            START: begin
                next_state = DATA0;
            end

            DATA0: next_state = DATA1;
            DATA1: next_state = DATA2;
            DATA2: next_state = DATA3;
            DATA3: next_state = DATA4;
            DATA4: next_state = DATA5;
            DATA5: next_state = DATA6;
            DATA6: next_state = DATA7;
            DATA7: next_state = STOP;

            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE;
                end
                else begin
                    next_state = STOP; // Stay in STOP state until we see a '1'
                end
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
