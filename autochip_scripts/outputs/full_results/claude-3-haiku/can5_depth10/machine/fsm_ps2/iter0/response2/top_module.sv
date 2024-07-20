module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter BYTE1 = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        done <= 0;
    end
    else begin
        case (state)
            BYTE1: begin
                if (in[2]) begin
                    state <= BYTE2;
                end
                else begin
                    state <= BYTE1;
                end
                done <= 0;
            end
            BYTE2: begin
                state <= BYTE3;
                done <= 0;
            end
            BYTE3: begin
                state <= DONE;
                done <= 0;
            end
            DONE: begin
                if (in[2]) begin
                    state <= BYTE2;
                end
                else begin
                    state <= BYTE1;
                end
                done <= 1;
            end
        endcase
    end
end

endmodule
