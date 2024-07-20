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
        RECEIVE = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;

    // Next state logic
    always @(*) begin
        next_state = state;
        done = 0;

        case (state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end

            START: begin
                if (in == 0)
                    next_state = RECEIVE;
                else
                    next_state = IDLE;
            end

            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end

            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    done = 1;
                end else
                    next_state = ERROR;
            end

            ERROR: begin
                if (in == 1)
                    next_state = IDLE;
            end
        endcase
    end

    // State and output updates
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    bit_count <= 3'd0;
                end

                RECEIVE: begin
                    out_byte[bit_count] <= in;
                    bit_count <= bit_count + 3'd1;
                end

                STOP: begin
                    // Do nothing, just wait for next
                end

                ERROR: begin
                    // Do nothing, wait for line to become idle
                end
            endcase
        end
    end
endmodule
