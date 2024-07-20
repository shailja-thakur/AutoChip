module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        if (state == BYTE3) begin
            out_bytes <= {out_bytes[15:0], in};
            done <= 1;
        end
        else if (state == BYTE2 || state == BYTE1) begin
            out_bytes <= {out_bytes[15:0], in};
        end
    end
end

always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2]) next_state = BYTE2;
            else next_state = BYTE1;
        end
        BYTE2: next_state = BYTE3;
        BYTE3: next_state = DONE;
        DONE: begin
            if (in[2]) next_state = BYTE1;
            else next_state = DONE;
        end
        default: next_state = BYTE1;
    endcase
end

endmodule
