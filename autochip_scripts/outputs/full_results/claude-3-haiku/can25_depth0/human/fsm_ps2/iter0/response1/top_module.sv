module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    WAIT_FOR_FIRST = 2'b00,
    RECEIVE_FIRST = 2'b01,
    RECEIVE_SECOND = 2'b10,
    RECEIVE_THIRD = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_FIRST: begin
                if (in[3]) begin
                    state <= RECEIVE_FIRST;
                end
                done <= 1'b0;
            end
            RECEIVE_FIRST: begin
                state <= RECEIVE_SECOND;
                done <= 1'b0;
            end
            RECEIVE_SECOND: begin
                state <= RECEIVE_THIRD;
                done <= 1'b0;
            end
            RECEIVE_THIRD: begin
                state <= WAIT_FOR_FIRST;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_FOR_FIRST;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
