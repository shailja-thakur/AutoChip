module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter WAIT = 2'b00; // Waiting for the first byte with in[3] = 1
parameter BYTE1 = 2'b01; // Received the first byte
parameter BYTE2 = 2'b10; // Received the second byte
parameter BYTE3 = 2'b11; // Received the third byte

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WAIT: begin
            if (in[3]) begin
                next_state = BYTE1;
                done = 1'b0;
            end
            else begin
                next_state = WAIT;
                done = 1'b0;
            end
        end
        BYTE1: begin
            next_state = BYTE2;
            done = 1'b0;
        end
        BYTE2: begin
            next_state = BYTE3;
            done = 1'b0;
        end
        BYTE3: begin
            next_state = WAIT;
            done = 1'b1;
        end
        default: begin
            next_state = WAIT;
            done = 1'b0;
        end
    endcase
end

endmodule
