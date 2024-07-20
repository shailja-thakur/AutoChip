module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3]) begin
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
                done <= 1;
                state <= 0;
            end
        endcase
    end
end

assign out_bytes = {byte3, byte2, byte1};

endmodule
