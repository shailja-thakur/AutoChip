module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done_reg;
reg [7:0] in_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        done_reg <= 0;
        in_reg <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    in_reg <= in;
                    state <= 1;
                end
            end
            1: begin
                if (in[3] == 1) begin
                    in_reg <= in;
                    state <= 2;
                end else begin
                    in_reg <= 0;
                    state <= 0;
                end
            end
            2: begin
                if (in[3] == 1) begin
                    in_reg <= in;
                    state <= 1;
                    done_reg <= 1;
                end else begin
                    in_reg <= 0;
                    state <= 0;
                end
            end
            default: begin
                in_reg <= 0;
                state <= 0;
            end
        endcase
    end
end

assign done = done_reg;

endmodule
