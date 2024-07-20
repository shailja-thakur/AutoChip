module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE,      // Waiting for the start bit
        START,     // Start bit detected
        DATA,      // Receiving data bits
        STOP,      // Waiting for the stop bit
        ERROR      // Error state - waiting for a valid stop bit
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;  // Counter for the data bits
    reg [7:0] data_shift_reg; // Shift register for received data bits

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            bit_count <= 0;
            data_shift_reg <= 0;
            out_byte <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA && next_state == DATA) begin
                bit_count <= bit_count + 1;
            end else if (next_state != DATA) begin
                bit_count <= 0;
            end
            if (current_state == DATA) begin
                data_shift_reg <= {in, data_shift_reg[7:1]};
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        done = 0;
        case (current_state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 8) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    out_byte = data_shift_reg;
                    done = 1;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
