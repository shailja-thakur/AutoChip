module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state, next_state;
reg z_next;
wire clk_out;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
            z_next = x;
        end
        
        B: begin
            if (x)
                next_state = B;
            else
                next_state = B;
            z_next = ~x;
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset)
        z <= 1'b0;
    else
        z <= z_next;
end

assign clk_out = clk;

endmodule
