module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0;
    end else begin
        case(state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                end
            end
            1: begin
                state <= 2;
            end
            2: begin
                if (in[3] == 1) begin
                    state <= 3;
                end else begin
                    state <= 0;
                end
            end
            3: begin
                state <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
