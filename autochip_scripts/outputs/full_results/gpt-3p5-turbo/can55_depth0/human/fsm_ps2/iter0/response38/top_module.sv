module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done_reg;
reg [7:0] in_reg;

wire in_bit3;
assign in_bit3 = in[3];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        done_reg <= 1'b0;
        in_reg <= 8'b0;
    end else begin
        case (state)
            3'b000: begin
                if (in_bit3) begin
                    state <= 3'b001;
                end else begin
                    state <= 3'b000;
                end
                in_reg <= in;
            end
            3'b001: begin
                if (in_bit3) begin
                    state <= 3'b010;
                end else begin
                    state <= 3'b000;
                end
                in_reg <= in;
            end
            3'b010: begin
                if (in_bit3) begin
                    done_reg <= 1'b1;
                    state <= 3'b011;
                end else begin
                    state <= 3'b000;
                end
                in_reg <= in;
            end
            3'b011: begin
                state <= 3'b000;
                done_reg <= 1'b0;
                in_reg <= in;
            end
            default: begin
                state <= 3'b000;
                done_reg <= 1'b0;
                in_reg <= in;
            end
        endcase
    end
end

assign done = done_reg;

endmodule
