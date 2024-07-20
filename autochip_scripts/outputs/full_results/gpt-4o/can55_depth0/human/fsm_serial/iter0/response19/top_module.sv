module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    
    // Declare state encoding
    typedef enum logic[2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    logic [2:0] bit_counter;

    // Output logic
    assign done = (current_state == STOP);
    
    // Sequential logic for state transitions and bit counting
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1'b1;
            end else begin
                bit_counter <= 3'b0;
            end
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111) begin // 8 data bits received
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit correct
                    next_state = IDLE;
                end else begin // Stop bit incorrect
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Wait for idle
                    next_state = IDLE;
                end
            end
        endcase
    end
    
endmodule
