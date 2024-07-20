module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] current_state, next_state;
parameter BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
        out_bytes <= 24'b0;
        done <= 0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            BYTE1: begin
                out_bytes[23:16] <= in;
                if (in[2])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                out_bytes[15:8] <= in;
                next_state = BYTE3;
            end
            BYTE3: begin
                out_bytes[7:0] <= in;
                out_bytes <= {out_bytes[15:0], 8'b0};
                next_state = DONE;
            end
            DONE: begin
                if (in[2])
                    next_state = BYTE1;
                else
                    next_state = DONE;
                done <= 1;
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end
end

endmodule
