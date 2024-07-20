module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE = 4'b0000,   // Idle state
        START = 4'b0001,  // Start bit detected
        BIT0 = 4'b0010,   // Data bit 0
        BIT1 = 4'b0011,   // Data bit 1
        BIT2 = 4'b0100,   // Data bit 2
        BIT3 = 4'b0101,   // Data bit 3
        BIT4 = 4'b0110,   // Data bit 4
        BIT5 = 4'b0111,   // Data bit 5
        BIT6 = 4'b1000,   // Data bit 6
        BIT7 = 4'b1001,   // Data bit 7
        STOP = 4'b1010,   // Stop bit validation
        ERROR = 4'b1011   // Error state: waiting for a stop bit
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = BIT0;
            end
            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: begin
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
