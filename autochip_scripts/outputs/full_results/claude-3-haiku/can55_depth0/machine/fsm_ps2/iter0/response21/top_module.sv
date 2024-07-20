module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            BYTE1: begin
                done <= 0;
                if (in[2]) begin
                    next_state <= BYTE2;
                end
                else begin
                    next_state <= BYTE1;
                end
            end
            BYTE2: begin
                next_state <= BYTE3;
            end
            BYTE3: begin
                next_state <= DONE;
            end
            DONE: begin
                done <= 1;
                if (in[2]) begin
                    next_state <= BYTE2;
                end
                else begin
                    next_state <= BYTE1;
                end
            end
        endcase
    end
end

endmodule
