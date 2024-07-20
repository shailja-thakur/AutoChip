module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter IDLE = 2'b00;
parameter BYTE1 = 2'b01;
parameter BYTE2 = 2'b10;
parameter BYTE3 = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= BYTE1;
                    done <= 0;
                end
                else begin
                    state <= IDLE;
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
                state <= IDLE;
                done <= 1;
            end
            default: begin
                state <= IDLE;
                done <= 0;
            end
        endcase
    end
end

endmodule
