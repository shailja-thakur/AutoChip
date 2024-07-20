module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [2:0] state;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [23:0] message_buffer;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
        byte_1 <= 8'b0;
        byte_2 <= 8'b0;
        message_buffer <= 24'b0;
        done <= 1'b0;
        out_bytes <= 24'b0;
    end else begin
        case(state)
            3'b000:
                if (in[3]) begin
                    byte_1 <= in;
                    state <= 3'b001;
                end
            3'b001:
                byte_2 <= in;
                state <= 3'b010;
            3'b010:
                message_buffer[15:0] <= byte_1;
                message_buffer[23:16] <= byte_2;
                message_buffer[7:0] <= in;
                state <= 3'b011;
            3'b011:
                done <= 1'b1;
                state <= 3'b100;
                out_bytes <= message_buffer;
            3'b100:
                done <= 1'b0;
                state <= 3'b000;
                message_buffer <= 24'b0;
        endcase
    end
end

endmodule
