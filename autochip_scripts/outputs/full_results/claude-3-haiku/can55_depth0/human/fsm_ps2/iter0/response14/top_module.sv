module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT = 2'b00;
localparam BYTE1 = 2'b01;
localparam BYTE2 = 2'b10;
localparam BYTE3 = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT: begin
                if (in[3]) begin
                    state <= BYTE1;
                    done <= 1'b0;
                end
                else begin
                    state <= WAIT;
                    done <= 1'b0;
                end
            end
            BYTE1: begin
                state <= BYTE2;
                done <= 1'b0;
            end
            BYTE2: begin
                state <= BYTE3;
                done <= 1'b0;
            end
            BYTE3: begin
                state <= WAIT;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
