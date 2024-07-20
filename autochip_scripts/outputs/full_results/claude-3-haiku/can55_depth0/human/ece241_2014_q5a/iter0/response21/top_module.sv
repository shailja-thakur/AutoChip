module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 2'd0, S1 = 2'd1, S2 = 2'd2;
reg [1:0] state, next_state;
reg [7:0] num, complement;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
            z = 1'b0;
            num = 8'b0;
            complement = 8'b0;
        end
        S1: begin
            if (x)
                next_state = S1;
            else
                next_state = S2;
            z = 1'b0;
            num = {num[6:0], x};
            complement = {complement[6:0], ~x};
        end
        S2: begin
            next_state = S0;
            z = 1'b1;
            num = 8'b0;
            complement = num + 1;
        end
    endcase
end

endmodule
