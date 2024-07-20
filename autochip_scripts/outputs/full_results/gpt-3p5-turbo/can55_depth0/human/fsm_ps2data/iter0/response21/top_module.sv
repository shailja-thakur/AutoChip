module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        byte_1 <= 8'b0;
        byte_2 <= 8'b0;
        byte_3 <= 8'b0;
        done <= 0;
        out_bytes <= 24'b0;
    end else begin
        case (state)
            2'b00:
                if (in[3] == 1) begin
                    state <= 2'b01;
                    byte_1 <= in;
                end
            2'b01:
                state <= 2'b10;
                byte_2 <= in;
            2'b10:
                begin
                    state <= 2'b00;
                    byte_3 <= in;
                    out_bytes <= {byte_1, byte_2, byte_3};
                    done <= 1;
                end
        endcase
    end
end

endmodule
