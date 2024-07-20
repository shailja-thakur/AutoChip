module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;
reg reset_d;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        reset_d <= 0;
        done <= 0;
    end else begin
        reset_d <= reset;
        case (state)
            0: begin
                if (reset_d || in[3] == 1) begin
                    state <= 1;
                    done <= 0;
                end
            end
            1: begin
                state <= 2;
                done <= 0;
            end
            2: begin
                state <= 3;
                done <= 0;
            end
            3: begin
                state <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
