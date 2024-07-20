module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    reg [1:0] state, next_state;
    reg done_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done_reg <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        done_reg = 1'b0;  // Default done signal is 0
        case(state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
                done_reg = 1'b1;  // Indicate a complete message received
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    assign done = done_reg;

endmodule
