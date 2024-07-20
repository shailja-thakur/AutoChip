module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_buffer;

    // State Transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 3'b001;
            end else if (current_state == STOP) begin
                bit_counter <= 3'b000;
            end
        end
    end

    // State Definition
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0) begin // Detect start bit
                    next_state = START;
                end
            end
            START: begin
                if (in == 1'b0) begin // Confirm start bit
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_counter == 3'b111) begin // All 8 data bits received
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    next_state = IDLE;
                    done = 1'b1;
                    out_byte = data_buffer;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                done = 1'b0;
                if (in == 1'b1) begin // Wait for line to become idle
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Data Buffering
    always_ff @(posedge clk) begin
        if (current_state == DATA) begin
            data_buffer <= {in, data_buffer[7:1]};
        end
    end

endmodule
