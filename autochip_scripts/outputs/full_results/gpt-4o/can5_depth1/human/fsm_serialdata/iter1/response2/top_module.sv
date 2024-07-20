module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM states
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        ERROR
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_count;
    reg [7:0] byte_data;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            byte_data <= 0;
            done <= 0;
            out_byte <= 8'b0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (state == DATA) begin
            byte_data[bit_count] <= in;
        end
    end

    always_comb begin
        next_state = state;
        done = 0;
        out_byte = 8'b0;  // Set to don't care when done is 0
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end
            START: begin
                // Wait for the start bit to complete
                if (in == 0) begin
                    next_state = DATA;
                    bit_count = 0;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_count == 7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    out_byte = byte_data;
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
