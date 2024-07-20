module top_module(
    input x,
    input y,
    output reg z
);

reg [2:0] state;

always @(*) begin
    case (state)
        3'b000: z = 1'b1;
        3'b001: z = 1'b0;
        3'b010: z = 1'b0;
        3'b011: z = 1'b0;
        3'b100: z = 1'b1;
        3'b101: z = 1'b0;
        3'b110: z = 1'b0;
        3'b111: z = 1'b1;
    endcase
end

always @(posedge x, posedge y) begin
    if (x) begin
        state <= 3'b100;
    end else if (y) begin
        state <= 3'b010;
    end else begin
        state <= {state[1:0], state[2]};
    end
end

endmodule
