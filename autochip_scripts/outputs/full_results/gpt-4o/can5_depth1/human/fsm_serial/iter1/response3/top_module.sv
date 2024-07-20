module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define state encoding
    typedef enum logic [3:0] {
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
        STOP    = 4'b1010,
        ERROR   = 4'b1011
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STOP && in == 1'b1) begin
                done <= 1'b1; // Byte has been correctly received
            end else begin
                done <= 1'b0; // Default state
            end
        end
    end

    always_comb begin
        next_state = current_state; // Default to stay in the current state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Look for start bit (0)
                    next_state <= START;
            end
            START: next_state <= DATA0; // Start bit detected, move to the first data bit
            DATA0: next_state <= DATA1;
            DATA1: next_state <= DATA2;
            DATA2: next_state <= DATA3;
            DATA3: next_state <= DATA4;
            DATA4: next_state <= DATA5;
            DATA5: next_state <= DATA6;
            DATA6: next_state <= DATA7;
            DATA7: begin
                if (in == 1'b1) // Expecting stop bit (1)
                    next_state <= STOP;
                else
                    next_state <= ERROR; // Error state if stop bit is not detected
            end
            STOP: next_state <= IDLE; // Byte received correctly, go back to idle
            ERROR: begin
                if (in == 1'b1)
                    next_state <= IDLE; // Wait for the line to go back to idle
            end
        endcase
    end

endmodule
