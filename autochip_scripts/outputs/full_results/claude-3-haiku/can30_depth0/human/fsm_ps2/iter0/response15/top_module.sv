module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    IDLE = 2'b00,
    BYTE1 = 2'b01,
    BYTE2 = 2'b10,
    BYTE3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    done = 1'b0;
    case (state)
        IDLE: begin
            if (in[3]) // Check if the MSB is set
                next_state = BYTE1;
            else
                next_state = IDLE;
        end
        BYTE1: begin
            next_state = BYTE2;
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            done = 1'b1;
            next_state = IDLE;
        end
    endcase
end

endmodule
