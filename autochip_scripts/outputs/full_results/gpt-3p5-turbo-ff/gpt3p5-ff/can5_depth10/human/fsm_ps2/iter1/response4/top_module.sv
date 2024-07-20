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
reg start_message;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0;
        start_message <= 0;
    end else begin
        case (state)
            0: begin
                if (start_message == 0 && in[3] == 1) begin
                    start_message <= 1;
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
                done <= 1;
                start_message <= 0;
            end
            default: state <= 0;
        endcase
    end
end

endmodule
