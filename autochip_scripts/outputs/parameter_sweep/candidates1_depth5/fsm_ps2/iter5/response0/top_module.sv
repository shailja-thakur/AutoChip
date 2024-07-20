module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [7:0] in_reg;
reg [3:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        in_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                    in_reg <= in;
                end else begin
                    in_reg <= 0;
                end
            end
            1: begin
                state <= 2;
                in_reg <= {in_reg[5:0], in};
            end
            2: begin
                state <= 0;
                in_reg <= {in_reg[5:0], in};
                if (in[3] == 1) begin
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
