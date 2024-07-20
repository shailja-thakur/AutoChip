module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] count;

parameter IDLE = 2'd0;
parameter WAIT_FIRST = 2'd1;
parameter WAIT_SECOND = 2'd2;
parameter WAIT_THIRD = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= WAIT_FIRST;
                    count <= 1;
                end
                else begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                end
            end
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_SECOND;
                    count <= 2;
                end
                else begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                end
            end
            WAIT_SECOND: begin
                if (in[3]) begin
                    state <= WAIT_THIRD;
                    count <= 3;
                end
                else begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                end
            end
            WAIT_THIRD: begin
                if (in[3]) begin
                    state <= IDLE;
                    count <= 0;
                    done <= 1;
                end
                else begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
