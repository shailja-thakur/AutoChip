module top_module (
    input wire clk,
    input wire in,
    input wire reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVING = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0) // detect start bit (0)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVING;
            end
            RECEIVING: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = RECEIVING;
            end
            STOP: begin
                if (in == 1) // check for stop bit (1)
                    next_state = IDLE;
                else
                    next_state = ERROR; // if stop bit is incorrect, go to error state
            end
            ERROR: begin
                if (in == 1) // wait for idle (1) before checking for start bit again
                    next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    done <= 0;
                    bit_count <= 3'd0;
                end
                START: begin
                    bit_count <= 3'd0;
                end
                RECEIVING: begin
                    shift_reg <= {in, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    if (in == 1) begin
                        out_byte <= shift_reg;
                        done <= 1;
                    end else begin
                        done <= 0;
                    end
                    bit_count <= 3'd0;
                end
                ERROR: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
