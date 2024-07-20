module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [7:0] in_reg;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 0;
    else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                    counter <= 0;
                    in_reg <= in;
                end else begin
                    state <= 0;
                end
            end
            1: begin
                state <= 2;
                in_reg <= in;
            end
            2: begin
                if (in[3] == 1) begin
                    state <= 0;
                    counter <= 0;
                    in_reg <= in;
                    done <= 1;
                end else if (counter == 0) begin
                    state <= 1;
                    counter <= 1;
                    in_reg <= in;
                end else begin
                    state <= 0;
                    counter <= 0;
                    in_reg <= in;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
