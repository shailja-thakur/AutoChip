module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] IDLE = 2'b00, FIRST = 2'b01, SECOND = 2'b10, THIRD = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            done = 0;
            if (in[3]) begin
                next_state = FIRST;
            end
            else begin
                next_state = IDLE;
            end
        end
        FIRST: begin
            done = 0;
            next_state = SECOND;
        end
        SECOND: begin
            done = 0;
            next_state = THIRD;
        end
        THIRD: begin
            done = 1;
            next_state = IDLE;
        end
        default: begin
            done = 0;
            next_state = IDLE;
        end
    endcase
end

endmodule
