module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_FOR_FIRST = 2'b00, WAIT_FOR_SECOND = 2'b01, WAIT_FOR_THIRD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_FIRST: begin
                if (in[3] == 1'b1) begin
                    state <= WAIT_FOR_SECOND;
                    done <= 0;
                end
                else begin
                    state <= WAIT_FOR_FIRST;
                    done <= 0;
                end
            end
            WAIT_FOR_SECOND: begin
                state <= WAIT_FOR_THIRD;
                done <= 0;
            end
            WAIT_FOR_THIRD: begin
                state <= WAIT_FOR_FIRST;
                done <= 1;
            end
            default: begin
                state <= WAIT_FOR_FIRST;
                done <= 0;
            end
        endcase
    end
end

endmodule
