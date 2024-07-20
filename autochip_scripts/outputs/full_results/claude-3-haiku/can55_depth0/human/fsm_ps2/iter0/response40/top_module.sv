module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] count;

parameter WAIT_FOR_FIRST = 2'b00;
parameter WAIT_FOR_SECOND = 2'b01;
parameter WAIT_FOR_THIRD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_FOR_SECOND;
                    count <= 1;
                end
            end
            WAIT_FOR_SECOND: begin
                count <= count + 1;
                if (count == 2) begin
                    state <= WAIT_FOR_THIRD;
                end
            end
            WAIT_FOR_THIRD: begin
                count <= count + 1;
                if (count == 3) begin
                    done <= 1;
                    state <= WAIT_FOR_FIRST;
                    count <= 0;
                end
            end
            default: begin
                state <= WAIT_FOR_FIRST;
                count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
