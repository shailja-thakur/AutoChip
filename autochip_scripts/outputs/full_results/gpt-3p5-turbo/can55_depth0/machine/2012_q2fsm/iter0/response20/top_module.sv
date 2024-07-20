module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else begin
            case (state)
                3'b000: begin
                    if (w == 1'b0)
                        state <= 3'b000;
                    else
                        state <= 3'b001;
                end
                3'b001: begin
                    if (w == 1'b0)
                        state <= 3'b010;
                    else
                        state <= 3'b011;
                end
                3'b010: begin
                    if (w == 1'b0)
                        state <= 3'b010;
                    else
                        state <= 3'b100;
                end
                3'b011: begin
                    if (w == 1'b0)
                        state <= 3'b000;
                    else
                        state <= 3'b101;
                end
                3'b100: begin
                    if (w == 1'b0)
                        state <= 3'b010;
                    else
                        state <= 3'b100;
                end
                3'b101: begin
                    if (w == 1'b0)
                        state <= 3'b101;
                    else
                        state <= 3'b110;
                end
                default: begin
                    if (w == 1'b0)
                        state <= 3'b100;
                    else
                        state <= 3'b010;
                end
            endcase
        end
    end

    always @(state) begin
        z = (state == 3'b101 | state == 3'b110);
    end

endmodule
