module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Output logic
    assign done = (state == BYTE_3);

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1) next_state = BYTE_1;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = IDLE;
        endcase
    end

    // Synchronous state update
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
endmodule
