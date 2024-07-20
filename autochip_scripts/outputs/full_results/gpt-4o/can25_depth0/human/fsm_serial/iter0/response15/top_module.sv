module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE,       // Waiting for start bit
        START,      // Start bit detected, waiting for data bits
        BIT0,       // Waiting for bit 0
        BIT1,       // Waiting for bit 1
        BIT2,       // Waiting for bit 2
        BIT3,       // Waiting for bit 3
        BIT4,       // Waiting for bit 4
        BIT5,       // Waiting for bit 5
        BIT6,       // Waiting for bit 6
        BIT7,       // Waiting for bit 7
        STOP,       // Waiting for stop bit
        ERROR       // Error state
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b000;
        end else begin
            state <= next_state;
            if (state >= BIT0 && state <= BIT7)
                bit_counter <= bit_counter + 1;
            else
                bit_counter <= 3'b000;
        end
    end
    
    always_comb begin
        done = 1'b0;
        next_state = state; // Default is to remain in current state

        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end

            START: begin
                next_state = BIT0;
            end

            BIT0: begin
                next_state = BIT1;
            end

            BIT1: begin
                next_state = BIT2;
            end

            BIT2: begin
                next_state = BIT3;
            end

            BIT3: begin
                next_state = BIT4;
            end

            BIT4: begin
                next_state = BIT5;
            end

            BIT5: begin
                next_state = BIT6;
            end

            BIT6: begin
                next_state = BIT7;
            end

            BIT7: begin
                next_state = STOP;
            end

            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE; // Successful byte received, go back to idle
                end else begin
                    next_state = ERROR; // Error in stop bit
                end
            end

            ERROR: begin
                if (in == 1'b1) // Wait for line to return to idle
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
