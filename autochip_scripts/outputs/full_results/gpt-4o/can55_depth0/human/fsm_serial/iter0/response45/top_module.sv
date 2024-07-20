module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE   = 3'b000,
        START  = 3'b001,
        DATA   = 3'b010,
        STOP   = 3'b011,
        ERROR  = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_byte;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            data_byte <= 8'd0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == DATA) begin
                data_byte[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end
            else if (state == IDLE || state == STOP || state == ERROR) begin
                bit_counter <= 3'd0;
            end
            
            if (state == STOP && in) begin
                done <= 1'b1; // Successfully received byte
            end
            else if (state != STOP) begin
                done <= 1'b0; // Reset done flag
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (!in) begin
                    next_state = START; // Start bit detected
                end
            end
            
            START: begin
                if (in) begin
                    next_state = IDLE; // False start bit detected, return to IDLE
                end
                else if (bit_counter == 3'd0) begin
                    next_state = DATA; // Valid start bit, proceed to receive data bits
                end
            end
            
            DATA: begin
                if (bit_counter == 3'd8) begin
                    next_state = STOP; // All 8 data bits received, proceed to check stop bit
                end
            end
            
            STOP: begin
                if (in) begin
                    next_state = IDLE; // Valid stop bit, return to IDLE for next byte
                end
                else begin
                    next_state = ERROR; // Invalid stop bit, enter ERROR state
                end
            end
            
            ERROR: begin
                if (in) begin
                    next_state = IDLE; // Stop bit detected, return to IDLE for next byte
                end
            end
        endcase
    end
endmodule
