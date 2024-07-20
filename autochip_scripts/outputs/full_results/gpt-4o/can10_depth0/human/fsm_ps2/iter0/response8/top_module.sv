module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    typedef enum reg [1:0] {
        IDLE    = 2'd0,
        BYTE1   = 2'd1,
        BYTE2   = 2'd2,
        BYTE3   = 2'd3
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
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
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    assign done = (state == BYTE3);

endmodule
