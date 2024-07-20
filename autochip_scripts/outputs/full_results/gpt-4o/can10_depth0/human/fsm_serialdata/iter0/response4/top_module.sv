module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // Define states
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        RECEIVE = 3'd2,
        STOP = 3'd3,
        ERR = 3'd4
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'b0;
            data_byte <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == RECEIVE)
                bit_count <= bit_count + 1;
            else if (next_state != state)
                bit_count <= 4'b0;

            if (next_state == RECEIVE)
                data_byte <= {in, data_byte[7:1]};
            else if (next_state == STOP && state == RECEIVE)
                out_byte <= data_byte;

            if (next_state == STOP)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end

            START: begin
                next_state = RECEIVE;
            end

            RECEIVE: begin
                if (bit_count == 4'd8)
                    next_state = (in == 1'b1) ? STOP : ERR;  // Check stop bit after 8 data bits
            end

            STOP: begin
                next_state = (in == 1'b1) ? IDLE : ERR;  // Verify line is idle after stop bit
            end

            ERR: begin
                if (in == 1'b1)
                    next_state = IDLE;  // Wait for line to be idle
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
