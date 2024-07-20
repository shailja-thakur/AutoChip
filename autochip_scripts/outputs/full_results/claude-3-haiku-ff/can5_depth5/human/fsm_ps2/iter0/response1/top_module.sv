module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    IDLE = 2'd0,
    BYTE1 = 2'd1,
    BYTE2 = 2'd2,
    BYTE3 = 2'd3;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in[3] == 1'b1) begin
                next_state = BYTE1;
                done = 1'b0;
            end
            else begin
                next_state = IDLE;
                done = 1'b0;
            end
        end
        BYTE1: begin
            next_state = BYTE2;
            done = 1'b0;
        end
        BYTE2: begin
            next_state = BYTE3;
            done = 1'b0;
        end
        BYTE3: begin
            next_state = IDLE;
            done = 1'b1;
        end
        default: begin
            next_state = IDLE;
            done = 1'b0;
        end
    endcase
end

endmodule
