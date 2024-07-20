module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    // State register
    state_t state, next_state;

    // Internal register to store concatenated bytes
    reg [23:0] shift_reg;

    // State transition logic
    always @(*) begin
        next_state = state; // Default to current state
        case (state)
            BYTE1: if (in[2]) next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (!in[2]) next_state = BYTE1;
        endcase
    end

    // State update and shift register logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state != DONE)
                shift_reg <= {shift_reg[15:0], in};
            if (state == DONE) begin
                out_bytes <= shift_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end
endmodule
