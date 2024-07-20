module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_counter; // Counter to count the data bits

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA)
                bit_counter <= bit_counter + 1;
            else
                bit_counter <= 3'b000;
        end
    end

    always @(*) begin
        done = 1'b0;
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0)  // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111)  // 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) begin  // Valid stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else  // Invalid stop bit
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1)  // Wait for the line to go idle (logic 1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
