module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
parameter [3:0] IDLE = 4'b0000,
                STATE1 = 4'b0001,
                STATE2 = 4'b0010,
                STATE3 = 4'b0011,
                STATE4 = 4'b0100,
                FOUND = 4'b0101;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= STATE1;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            STATE1: begin
                if (data == 1'b1)
                    state <= STATE2;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            STATE2: begin
                if (data == 1'b0)
                    state <= STATE3;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            STATE3: begin
                if (data == 1'b1)
                    state <= STATE4;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            STATE4: begin
                if (data == 1'b1)
                    state <= FOUND;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            FOUND: begin
                state <= FOUND;
                start_shifting <= 1'b1;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
