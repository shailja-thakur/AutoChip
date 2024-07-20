module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done <= 0;
        out_bytes <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                end
            end
            1: begin
                byte2 <= in;
                state <= 2;
            end
            2: begin
                byte3 <= in;
                state <= 0;
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
            end
            default: begin
                state <= 0;
                byte1 <= 0;
                byte2 <= 0;
                byte3 <= 0;
                done <= 0;
                out_bytes <= 0;
            end
        endcase
    end
end

endmodule
