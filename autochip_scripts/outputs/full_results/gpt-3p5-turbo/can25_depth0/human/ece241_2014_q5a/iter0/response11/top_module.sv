module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg z;
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00;
    else begin
        case(state)
            2'b00: begin
                if (x == 1'b0)
                    state <= 2'b00;
                else
                    state <= 2'b01;
            end
            2'b01: begin
                if (x == 1'b0)
                    state <= 2'b01;
                else
                    state <= 2'b10;
            end
            2'b10: begin
                if (x == 1'b0)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
        endcase
    end
end

always @(state) begin
    case(state)
        2'b00: z <= ~x;
        2'b01: z <= ~x + 1'b1;
        2'b10: z <= 1'b0;
    endcase
end

endmodule
