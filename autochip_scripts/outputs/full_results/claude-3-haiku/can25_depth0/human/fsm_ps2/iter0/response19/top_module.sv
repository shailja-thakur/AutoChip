module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] WAITING = 2'b00,
                 BYTE1   = 2'b01,
                 BYTE2   = 2'b10,
                 BYTE3   = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAITING;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAITING: begin
                if (in[3]) begin
                    state <= BYTE1;
                end
                else begin
                    state <= WAITING;
                end
                done <= 1'b0;
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
                state <= WAITING;
                done <= 1'b1; // Signal the receipt of a message
            end
        endcase
    end
end

endmodule
