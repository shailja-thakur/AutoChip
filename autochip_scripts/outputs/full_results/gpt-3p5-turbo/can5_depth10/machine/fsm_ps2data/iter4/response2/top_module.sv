module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @(state, in) begin
        case (state)
            3'b000: next_state = (in[2] == 1) ? 3'b001 : 3'b000;
            3'b001: next_state = (in[0] == 1) ? 3'b010 : 3'b001;
            3'b010: next_state = (in[0] == 1) ? 3'b011 : 3'b010;
            3'b011: next_state = (in[0] == 1) ? 3'b011 : 3'b000;
            default: next_state = 3'b000;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            out_bytes <= (state == 3'b011) ? {out_bytes[15:0], in} : {out_bytes[15:0], 8'b0};
            done <= (state == 3'b011) ? 1 : 0;
        end
    end

endmodule
