module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    parameter BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            BYTE1: begin
                done = 1'b0;
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                done = 1'b0;
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 1'b0;
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            default: begin
                done = 1'b0;
                next_state = BYTE1;
            end
        endcase
    end

endmodule
