module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;
    reg [1:0] byte_count;

    // State encoding
    localparam IDLE = 2'd0,
               BYTE1 = 2'd1,
               BYTE2 = 2'd2,
               BYTE3 = 2'd3;

    // State transition logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1; // Signal done after receiving the third byte
            end
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
endmodule
