module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter [2:0] IDLE = 3'b000,
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100,
                FOUND = 3'b101;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = S1;
            else
                next_state = IDLE;
        end
        S1: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = S2;
            else
                next_state = IDLE;
        end
        S2: begin
            start_shifting = 1'b0;
            if (data == 1'b0)
                next_state = S3;
            else
                next_state = IDLE;
        end
        S3: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = S4;
            else
                next_state = IDLE;
        end
        S4: begin
            start_shifting = 1'b1;
            next_state = FOUND;
        end
        FOUND: begin
            start_shifting = 1'b1;
            next_state = FOUND;
        end
        default: begin
            start_shifting = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
