module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [3:0] bit_count;      // To count 8 data bits
    reg [7:0] data_buffer;    // Buffer for the received data byte

    // Sequential logic for state transitions and bit_count management
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
            data_buffer <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                bit_count <= bit_count + 4'd1;
                data_buffer <= {in, data_buffer[7:1]}; // Shift bits in LSB first
            end else if (state != DATA) begin
                bit_count <= 4'd0;
            end

            if (state == STOP) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Combinational logic for next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin  // Detect start bit (0)
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 4'd8) begin  // All 8 bits received
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin  // Verify stop bit (1)
                    next_state = IDLE;
                    out_byte = data_buffer;
                end else begin
                    next_state = ERROR; // Stop bit is incorrect
                }
            end
            ERROR: begin
                if (in == 1'b1) begin  // Wait until line is idle again (stop bit detected)
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
