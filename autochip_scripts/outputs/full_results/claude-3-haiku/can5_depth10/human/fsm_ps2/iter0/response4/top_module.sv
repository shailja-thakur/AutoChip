module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_FOR_FIRST_BYTE = 2'b00;
parameter WAIT_FOR_SECOND_BYTE = 2'b01;
parameter WAIT_FOR_THIRD_BYTE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST_BYTE;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3]) begin
                    state <= WAIT_FOR_SECOND_BYTE;
                    done <= 1'b0;
                end
                else begin
                    state <= WAIT_FOR_FIRST_BYTE;
                    done <= 1'b0;
                end
            end
            WAIT_FOR_SECOND_BYTE: begin
                state <= WAIT_FOR_THIRD_BYTE;
                done <= 1'b0;
            end
            WAIT_FOR_THIRD_BYTE: begin
                state <= WAIT_FOR_FIRST_BYTE;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_FOR_FIRST_BYTE;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
