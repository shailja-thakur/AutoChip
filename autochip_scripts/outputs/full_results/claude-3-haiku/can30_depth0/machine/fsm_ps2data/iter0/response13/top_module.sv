module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam BYTE1 = 2'b00;
localparam BYTE2 = 2'b01;
localparam BYTE3 = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            BYTE1: begin
                out_bytes <= {out_bytes[15:0], in};
                if (in[2]) state <= BYTE2;
                else state <= BYTE1;
                done <= 1'b0;
            end
            BYTE2: begin
                out_bytes <= {out_bytes[15:0], in};
                state <= BYTE3;
                done <= 1'b0;
            end
            BYTE3: begin
                out_bytes <= {out_bytes[15:0], in};
                state <= DONE;
                done <= 1'b0;
            end
            DONE: begin
                done <= 1'b1;
                if (in[2]) state <= BYTE1;
                else state <= DONE;
            end
            default: state <= BYTE1;
        endcase
    end
end

endmodule
