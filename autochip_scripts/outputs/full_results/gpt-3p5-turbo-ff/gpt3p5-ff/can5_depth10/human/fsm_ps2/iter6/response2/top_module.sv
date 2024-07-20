module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0;
    end else begin
        state <= next_state;
        case (state)
            0: begin
                if (in[3] == 1) begin
                    byte1 <= in;
                    next_state <= 1;
                end else begin
                    next_state <= 0;
                end
            end
            1: begin
                byte2 <= in;
                next_state <= 2;
            end
            2: begin
                byte3 <= in;
                next_state <= 0;
                done <= 1;
            end
            default: next_state <= 0;
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        done <= 0;
    end else if (done == 1) begin
        done <= 0;
    end
end

endmodule
