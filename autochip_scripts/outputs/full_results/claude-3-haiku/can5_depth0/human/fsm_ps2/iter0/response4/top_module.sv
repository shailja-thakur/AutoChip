module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] STATE_WAIT = 2'b00,
                 STATE_BYTE1 = 2'b01,
                 STATE_BYTE2 = 2'b10,
                 STATE_BYTE3 = 2'b11;

reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    next_state <= STATE_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    next_state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 0;
            end
            STATE_BYTE1: begin
                next_state <= STATE_BYTE2;
                byte_count <= 2;
                done <= 0;
            end
            STATE_BYTE2: begin
                next_state <= STATE_BYTE3;
                byte_count <= 3;
                done <= 0;
            end
            STATE_BYTE3: begin
                next_state <= STATE_WAIT;
                byte_count <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
