module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Declaration
    typedef enum logic [2:0] {
        IDLE,       // Idle state
        START,      // Start bit detection
        DATA,       // Data bit receiving
        STOP,       // Stop bit verification
        ERROR       // Error handling state
    } state_t;
    
    state_t state, next_state;

    // Data bit counter
    reg [2:0] bit_counter; 

    // FSM State Transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            if (state == DATA) begin
                bit_counter <= bit_counter + 3'd1;
            end else if (state != DATA) begin
                bit_counter <= 3'd0;
            end
        end
    end

    // FSM Next State Logic
    always_comb begin
        // default assignments
        next_state = state;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'd7) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Verify stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) // Wait for idle line
                    next_state = IDLE;
            end
        endcase
    end

endmodule
