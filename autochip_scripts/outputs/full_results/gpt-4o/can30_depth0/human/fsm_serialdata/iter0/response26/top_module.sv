module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // Define state encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] shift_reg;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            shift_reg <= 8'b0;
            done <= 1'b0;
            out_byte <= 8'b0;
        end else begin
            current_state <= next_state;
            if (next_state == DATA) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_counter <= bit_counter + 3'd1;
            end else if (next_state == STOP) begin
                out_byte <= shift_reg;
            end else if (next_state != current_state) begin
                bit_counter <= 3'd0;
                shift_reg <= 8'b0;
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = START;
            end
            START: begin
                if (in == 1'b0) next_state = DATA;
                else next_state = IDLE;
            end
            DATA: begin
                if (bit_counter == 3'd7) next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                done = 1'b0;
                if (in == 1'b1) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
