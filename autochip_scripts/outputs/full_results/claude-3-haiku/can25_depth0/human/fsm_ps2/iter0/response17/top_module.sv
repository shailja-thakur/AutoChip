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
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FIRST;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_SECOND;
                    byte_count <= 1;
                end
                else begin
                    state <= WAIT_FIRST;
                    byte_count <= 0;
                end
                done <= 0;
            end
            WAIT_SECOND: begin
                if (byte_count == 1) begin
                    byte_count <= 2;
                    state <= WAIT_THIRD;
                end
                else begin
                    byte_count <= 1;
                    state <= WAIT_SECOND;
                end
                done <= 0;
            end
            WAIT_THIRD: begin
                if (byte_count == 2) begin
                    byte_count <= 0;
                    state <= WAIT_FIRST;
                    done <= 1;
                end
                else begin
                    byte_count <= 2;
                    state <= WAIT_THIRD;
                    done <= 0;
                end
            end
            default: begin
                state <= WAIT_FIRST;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
