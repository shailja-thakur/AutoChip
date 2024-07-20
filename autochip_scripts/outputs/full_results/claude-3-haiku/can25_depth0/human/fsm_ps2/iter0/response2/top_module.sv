module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    WAIT_FIRST = 2'd0,
    WAIT_SECOND = 2'd1, 
    WAIT_THIRD = 2'd2;

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FIRST;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_SECOND;
                    count <= 1;
                end
                else begin
                    state <= WAIT_FIRST;
                    count <= 0;
                end
                done <= 0;
            end
            WAIT_SECOND: begin
                if (count == 1) begin
                    state <= WAIT_THIRD;
                    count <= 2;
                end
                else begin
                    state <= WAIT_FIRST;
                    count <= 0;
                end
                done <= 0;
            end
            WAIT_THIRD: begin
                if (count == 2) begin
                    state <= WAIT_FIRST;
                    count <= 0;
                    done <= 1;
                end
                else begin
                    state <= WAIT_FIRST;
                    count <= 0;
                    done <= 0;
                end
            end
            default: begin
                state <= WAIT_FIRST;
                count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
