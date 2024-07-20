module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] shift_reg [2:0];
reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    shift_reg[0] <= in;
                    state <= 1;
                end
            end
            1: begin
                shift_reg[1] <= in;
                state <= 2;
            end
            2: begin
                shift_reg[2] <= in;
                done <= 1;
                state <= 0;
            end
            default: begin
                state <= 0;
            end
        endcase
    end
end

endmodule
