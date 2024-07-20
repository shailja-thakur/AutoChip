module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    typedef enum logic [1:0] {
        IDLE     = 2'd0,
        BYTE1    = 2'd1,
        BYTE2    = 2'd2,
        BYTE3    = 2'd3
    } state_t;

    state_t state, next_state;
    logic [1:0] byte_count;
    logic done;

    // State Update Logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 2'd0;
        end else begin
            state <= next_state;
            if (next_state == BYTE1) begin
                byte_count <= 2'd1;
            end else if (next_state == BYTE2) begin
                byte_count <= 2'd2;
            end else if (next_state == BYTE3) begin
                byte_count <= 2'd3;
            end else if (next_state == IDLE) begin
                byte_count <= 2'd0;
            end
        end
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        done = 1'b0;
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
                done = 1'b1; // Signal done in the cycle immediately after the third byte of the message
            end
        endcase
    end

endmodule
