module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM states
    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state, next_state;
    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_cnt <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state <= START;
                end
                done <= 1'b0;
            end

            START: begin
                if (in == 1'b0) begin // Ensure start bit is 0
                    bit_cnt <= 3'b0;
                    next_state <= DATA;
                end else begin
                    next_state <= IDLE; // False start bit, back to IDLE
                end
            end

            DATA: begin
                shift_reg[bit_cnt] <= in;
                bit_cnt <= bit_cnt + 1;
                if (bit_cnt == 3'd7) begin
                    next_state <= STOP;
                end else begin
                    next_state <= DATA;
                end
            end

            STOP: begin
                if (in == 1'b1) begin // Stop bit should be 1
                    out_byte <= shift_reg;
                    done <= 1'b1;
                    next_state <= IDLE;
                end else begin
                    next_state <= IDLE; // Stop bit not 1, back to IDLE eventually finding new start bit
                end
            end

            default: begin
                next_state <= IDLE;
            end
        endcase
    end

    always @(*) begin
        case (state)
            IDLE: next_state = (in == 1'b0) ? START : IDLE;
            START: next_state = DATA;
            DATA: next_state = (bit_cnt == 3'd7) ? STOP : DATA;
            STOP: next_state = (in == 1'b1) ? IDLE : IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
