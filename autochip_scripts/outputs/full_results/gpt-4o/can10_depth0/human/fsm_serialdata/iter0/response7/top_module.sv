module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_count;
    reg [7:0] byte_buffer;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 4'd0;
            byte_buffer <= 8'd0;
            out_byte <= 8'd0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        done = 0;
        
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end

            START: begin
                next_state = DATA;
                bit_count = 4'd0;
                byte_buffer = 8'd0;
            end

            DATA: begin
                if (bit_count < 8) begin
                    byte_buffer[bit_count] = in;
                    bit_count = bit_count + 1;
                    if (bit_count == 7) begin
                        next_state = STOP;
                    end
                end
            end

            STOP: begin
                if (in == 1) begin
                    out_byte = byte_buffer;
                    done = 1;
                    next_state = IDLE;
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
