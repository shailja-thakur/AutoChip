module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (next_state == BYTE_3 && state == BYTE_2) begin
                done <= 1'b1;
            end
            else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE_1;
                end
            end

            BYTE_1: begin
                next_state = BYTE_2;
            end

            BYTE_2: begin
                next_state = BYTE_3;
            end

            BYTE_3: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
