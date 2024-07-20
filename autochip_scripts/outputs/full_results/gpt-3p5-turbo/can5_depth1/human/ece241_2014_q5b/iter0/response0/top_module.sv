module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// State declaration
reg [1:0] state, next_state;

// Output declaration
reg z_reg;

// State encoding
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(state or x) begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
            end
        B: begin
            if (x)
                next_state = B;
            else
                next_state = B;
            end
        default: next_state = A;
    endcase
end


always @(posedge clk) begin
    case (state)
        A: z_reg <= 1'b0;
        B: z_reg <= 1'b1;
        default: z_reg <= 1'b0;
    endcase
end

assign z = z_reg;

endmodule
