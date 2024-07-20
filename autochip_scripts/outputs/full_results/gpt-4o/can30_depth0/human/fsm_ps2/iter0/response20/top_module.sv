module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    reg [2:0] state, next_state;
    reg [1:0] count;
    parameter IDLE = 3'd0,
              BYTE_1 = 3'd1,
              BYTE_2 = 3'd2,
              BYTE_3 = 3'd3,
              DONE = 3'd4;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                done = 0;
                if (in[3] == 1)
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end
            BYTE_1: begin
                done = 0;
                next_state = BYTE_2;
            end
            BYTE_2: begin
                done = 0;
                next_state = BYTE_3;
            end
            BYTE_3: begin
                done = 1;
                next_state = DONE;
            end
            DONE: begin
                done = 0;
                if (in[3] == 1)
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end
            default: begin
                done = 0;
                next_state = IDLE;
            end
        endcase
    end
endmodule
