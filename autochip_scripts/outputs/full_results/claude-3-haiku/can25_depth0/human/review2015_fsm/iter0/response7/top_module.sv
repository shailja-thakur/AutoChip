module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

reg [3:0] state, next_state;
parameter S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6;

always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        S0: begin // Look for start sequence 1101
            if (data == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (data == 1'b1)
                next_state = S2;
            else
                next_state = S0;
        end
        S2: begin
            if (data == 1'b0)
                next_state = S3;
            else
                next_state = S0;
        end
        S3: begin
            if (data == 1'b1)
                next_state = S4;
            else
                next_state = S0;
        end
        S4: begin // Shift in 4 bits
            shift_ena = 1;
            if (next_state == S5)
                next_state = S5;
            else
                next_state = S4;
        end
        S5: begin // Wait for done_counting
            counting = 1;
            if (done_counting)
                next_state = S6;
            else
                next_state = S5;
        end
        S6: begin // Notify and wait for ack
            done = 1;
            if (ack)
                next_state = S0;
            else
                next_state = S6;
        end
    endcase
end

endmodule
