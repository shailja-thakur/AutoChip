module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    WAIT_FIRST = 2'b00,
    WAIT_SECOND = 2'b01,
    WAIT_THIRD = 2'b10;

reg [1:0] state;
reg [1:0] byte_count;

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
                state <= WAIT_THIRD;
                byte_count <= 2;
                done <= 0;
            end
            WAIT_THIRD: begin
                state <= WAIT_FIRST;
                byte_count <= 0;
                done <= 1;
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
