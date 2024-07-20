module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_FOR_MESSAGE = 0;
localparam STATE_RECEIVING_MESSAGE = 1;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_FOR_MESSAGE;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT_FOR_MESSAGE: begin
                if (in[3]) begin
                    state <= STATE_RECEIVING_MESSAGE;
                    byte_count <= 1;
                end
                else begin
                    byte_count <= 0;
                    done <= 0;
                end
            end
            STATE_RECEIVING_MESSAGE: begin
                byte_count <= byte_count + 1;
                if (byte_count == 3) begin
                    state <= STATE_WAIT_FOR_MESSAGE;
                    done <= 1;
                end
                else if (byte_count > 3) begin
                    state <= STATE_WAIT_FOR_MESSAGE;
                    byte_count <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
