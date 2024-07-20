module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_t;
    state_t state, next_state;

    reg [23:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state != DONE) begin
                shift_reg <= {shift_reg[15:0], in}; // Shift left and insert new byte
            end

            if (next_state == DONE && state != DONE) begin
                done <= 1;
                out_bytes <= shift_reg; // Set out_bytes to accumulated shift_reg value
            end else begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        case(state)
            BYTE1: begin
                if (in[2] == 1) next_state = BYTE2;
                else next_state = BYTE1;
            end
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: next_state = BYTE1;
            default: next_state = BYTE1; // Default case for safe FSM
        endcase
    end

endmodule
