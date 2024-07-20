module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_reg;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next State and Output Logic
    always @(*) begin
        next_state = state; // Default to holding state
        done = 1'b0;        // Default done signal to 0
        case (state)
            BYTE1: begin
                if (in[2])
                    next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (!in[2])
                    next_state = BYTE1;
            end
        endcase
    end

    // Shift Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            if (state != DONE) begin
                shift_reg <= {shift_reg[15:0], in};
                out_bytes <= 24'b0;
            end else begin
                out_bytes <= shift_reg;
            end
        end
    end

endmodule
