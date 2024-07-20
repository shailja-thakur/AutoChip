module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] count;

localparam WAIT_FOR_START = 2'd0;
localparam COLLECT_MSG = 2'd1;
localparam SIGNAL_DONE = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3]) begin
                    state <= COLLECT_MSG;
                    count <= 1;
                end
                else begin
                    state <= WAIT_FOR_START;
                    count <= 0;
                end
                done <= 0;
            end
            COLLECT_MSG: begin
                if (count == 2) begin
                    state <= SIGNAL_DONE;
                end
                else if (in[3]) begin
                    count <= count + 1;
                end
                else begin
                    state <= WAIT_FOR_START;
                    count <= 0;
                end
                done <= 0;
            end
            SIGNAL_DONE: begin
                state <= WAIT_FOR_START;
                count <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
