module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == IDLE) begin
                bit_count <= 3'd0;
            end else if (current_state == DATA) begin
                bit_count <= bit_count + 1;
            end
        end
    end

    always @(*) begin
        next_state = current_state; // Default stay in current state
        done = 1'b0; // Default done is low

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA; // Move to data bits reception
            end
            DATA: begin
                if (bit_count == 3'd7) // All 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected correctly
                    done = 1'b0;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Stop bit not detected, move to error state
                end
            end
            ERROR: begin
                if (in == 1'b1) // Keep waiting until line goes to idle (logic 1)
                    next_state = IDLE; 
            end
        endcase
    end

endmodule
