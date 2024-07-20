module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,     // Waiting for start bit
        START,    // Detected start bit
        DATA,     // Receiving data bits
        STOP,     // Checking stop bit
        ERROR     // Error state (waiting for correct stop bit)
    } state_t;

    state_t state, next_state;
    
    reg [2:0] data_bit_count; // Counter for data bits received
    reg [7:0] shift_reg;      // Shift register for received bits

    // Synchronous process: Update state and output registers
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_bit_count <= 3'd0;
            shift_reg <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                shift_reg <= {in, shift_reg[7:1]}; // Shift new bit into register
            end
            if (state == STOP && in == 1'b1) begin
                out_byte <= shift_reg; // Capture the byte once stop bit is verified
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
            if (state == START || state == DATA) begin
                data_bit_count <= data_bit_count + 1;
            end else begin
                data_bit_count <= 3'd0;
            end
        end 
    end

    // State transition logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)  // Detected start bit (0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (data_bit_count == 3'd7)  // After receiving 8 bits
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1)  // Stop bit is correct (1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1)  // Wait until stop bit is detected
                    next_state = IDLE;
            end
        endcase
    end

endmodule
