module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_FOR_BYTE1 = 2'b00;
localparam WAIT_FOR_BYTE2 = 2'b01;
localparam WAIT_FOR_BYTE3 = 2'b10;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_BYTE1;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WAIT_FOR_BYTE1: begin
            if (in[3]) begin
                next_state <= WAIT_FOR_BYTE2;
            end
            else begin
                next_state <= WAIT_FOR_BYTE1;
            end
            done <= 1'b0;
        end
        WAIT_FOR_BYTE2: begin
            next_state <= WAIT_FOR_BYTE3;
            done <= 1'b0;
        end
        WAIT_FOR_BYTE3: begin
            next_state <= WAIT_FOR_BYTE1;
            done <= 1'b1;
        end
        default: begin
            next_state <= WAIT_FOR_BYTE1;
            done <= 1'b0;
        end
    endcase
end

endmodule
