module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, WAIT_BYTE1 = 2'b01, WAIT_BYTE2 = 2'b10, WAIT_BYTE3 = 2'b11;
reg [1:0] state, next_state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                byte_count <= 0;
                done <= 0;
                if (in[3]) begin
                    next_state <= WAIT_BYTE1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            WAIT_BYTE1: begin
                byte_count <= 1;
                done <= 0;
                next_state <= WAIT_BYTE2;
            end
            WAIT_BYTE2: begin
                byte_count <= 2;
                done <= 0;
                next_state <= WAIT_BYTE3;
            end
            WAIT_BYTE3: begin
                byte_count <= 3;
                done <= 1;
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
