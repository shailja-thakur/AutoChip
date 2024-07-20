module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam IDLE = 2'b00;
localparam RECV1 = 2'b01;
localparam RECV2 = 2'b10;
localparam RECV3 = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= RECV1;
                end
                done <= 0;
            end
            RECV1: begin
                state <= RECV2;
            end
            RECV2: begin
                state <= RECV3;
            end
            RECV3: begin
                done <= 1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
                done <= 0;
            end
        endcase
    end
end

endmodule
