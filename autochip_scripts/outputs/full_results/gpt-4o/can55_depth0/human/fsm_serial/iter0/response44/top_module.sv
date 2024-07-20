module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] data_bit_count;
    
    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            data_bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_bit_count <= data_bit_count + 1;
            end else begin
                data_bit_count <= 3'b000;
            end
        end
    end
    
    // Next State Logic
    always @(*) begin
        next_state = current_state; // Default state
        done = 0; // Default done signal
        case (current_state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START; // Detect start bit
                end
            end
            START: begin
                next_state = DATA; // Transition to data reception state
            end
            DATA: begin
                if (data_bit_count == 3'b111) begin
                    next_state = STOP; // After receiving 8 data bits, move to STOP state
                end else begin
                    next_state = DATA; // Continue receiving data bits
                end
            end
            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE; // Successful byte received, move back to IDLE
                end else begin
                    next_state = ERROR; // Stop bit was incorrect, move to ERROR state
                end
            end
            ERROR: begin
                if (in == 1) begin
                    next_state = IDLE; // Wait until line is idle, then move to IDLE
                end
            end
        endcase
    end

endmodule
