module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Declarations
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t currentState, nextState;
    reg [2:0] bitCount;

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            currentState <= IDLE;
            bitCount <= 0;
            done <= 0;
        end
        else begin
            currentState <= nextState;
            if (currentState == IDLE || currentState == STOP || currentState == ERROR) begin
                bitCount <= 0;
            end else if (currentState == DATA) begin
                bitCount <= bitCount + 1;
            end
        end
    end

    // Next State Logic
    always_comb begin
        nextState = currentState;
        done = 0;
        
        case (currentState)
            IDLE: begin
                if (!in) // Start bit detected
                    nextState = START;
            end
            
            START: begin
                nextState = DATA;
            end

            DATA: begin
                if (bitCount == 3'd7) // All 8 data bits received
                    nextState = STOP;
            end

            STOP: begin
                if (in) begin // Stop bit detected
                    done = 1;
                    nextState = IDLE;
                end
                else begin
                    nextState = ERROR;
                end
            end

            ERROR: begin
                if (in) // Wait for stop bit before resetting
                    nextState = IDLE;
            end
        endcase
    end
endmodule
