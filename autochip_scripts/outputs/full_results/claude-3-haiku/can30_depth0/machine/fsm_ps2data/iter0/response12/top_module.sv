module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state, next_state;
parameter BYTE1 = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == BYTE1)
            out_bytes[23:16] <= in;
        else if (state == BYTE2)
            out_bytes[15:8] <= in;
        else if (state == BYTE3)
            out_bytes[7:0] <= in;
        else if (state == DONE)
            done <= 1'b1;
    end
end

always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2])
                next_state = BYTE2;
            else
                next_state = BYTE1;
        end
        BYTE2: next_state = BYTE3;
        BYTE3: next_state = DONE;
        DONE: begin
            if (in[2])
                next_state = BYTE1;
            else
                next_state = DONE;
        end
    endcase
end

endmodule
