module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAITING = 2'd0;
localparam BYTE1 = 2'd1;
localparam BYTE2 = 2'd2;
localparam BYTE3 = 2'd3;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAITING;
        done <= 0;
    end
    else begin
        case (state)
            WAITING: begin
                if (in[3]) begin
                    state <= BYTE1;
                    done <= 0;
                end
                else begin
                    state <= WAITING;
                    done <= 0;
                end
            end
            BYTE1: begin
                state <= BYTE2;
                done <= 0;
            end
            BYTE2: begin
                state <= BYTE3;
                done <= 0;
            end
            BYTE3: begin
                state <= WAITING;
                done <= 1;
            end
            default: begin
                state <= WAITING;
                done <= 0;
            end
        endcase
    end
end

endmodule
