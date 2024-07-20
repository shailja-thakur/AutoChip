module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] current_state, next_state;
parameter BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
                next_state = BYTE1;
            end
            done = 1'b0;
        end
        BYTE2: begin
            next_state = BYTE3;
            done = 1'b0;
        end
        BYTE3: begin
            next_state = DONE;
            done = 1'b0;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
                next_state = BYTE1;
            end
            done = 1'b1;
        end
        default: begin
            next_state = BYTE1;
            done = 1'b0;
        end
    endcase
end

endmodule
