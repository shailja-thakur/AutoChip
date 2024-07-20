module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset)
        state <= 3'b000;
    else begin
        case (state)
            3'b000:
                if (w)
                    state <= 3'b001;
            3'b001:
                if (w)
                    state <= 3'b010;
                else
                    state <= 3'b000;
            3'b010:
                if (w)
                    state <= 3'b011;
                else
                    state <= 3'b001;
            3'b011:
                if (w)
                    state <= 3'b010;
                else
                    state <= 3'b000;
            3'b100:
                if (w)
                    state <= 3'b011;
                else
                    state <= 3'b010;
            3'b101:
                if (w)
                    state <= 3'b101;
                else
                    state <= 3'b011;
        endcase
    end
end

always @(state) begin
    if (state == 3'b100 || state == 3'b101)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
