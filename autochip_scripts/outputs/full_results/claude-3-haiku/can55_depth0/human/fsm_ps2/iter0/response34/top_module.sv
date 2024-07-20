module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter IDLE = 2'b00;
parameter WAITING_FIRST = 2'b01;
parameter WAITING_SECOND = 2'b10;
parameter WAITING_THIRD = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= WAITING_SECOND;
                end
                else begin
                    state <= IDLE;
                end
                done <= 0;
            end
            WAITING_SECOND: begin
                if (in[3]) begin
                    state <= WAITING_THIRD;
                end
                else begin
                    state <= WAITING_SECOND;
                end
                done <= 0;
            end
            WAITING_THIRD: begin
                if (in[3]) begin
                    state <= IDLE;
                    done <= 1;
                end
                else begin
                    state <= WAITING_THIRD;
                    done <= 0;
                end
            end
            default: begin
                state <= IDLE;
                done <= 0;
            end
        endcase
    end
end

endmodule
