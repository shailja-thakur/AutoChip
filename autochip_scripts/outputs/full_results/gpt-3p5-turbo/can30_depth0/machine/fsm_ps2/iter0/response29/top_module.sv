module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg done_reg;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else begin
        case(state)
            2'b00: begin
                if (in[2] == 1'b1)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: state <= 2'b10;
            2'b10: state <= 2'b11;
            2'b11: begin
                if (in[2] == 1'b0)
                    state <= 2'b00;
                else
                    state <= 2'b01;
            end
        endcase
    end
end

always @(posedge clk) begin
    done_reg <= (state == 2'b11);
end

assign done = done_reg;

endmodule
