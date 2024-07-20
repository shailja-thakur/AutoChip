module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (x) begin
                next_state = B;
                z <= 1;
            end else begin
                next_state = A;
                z <= 0;
            end
        end
        B: begin
            if (x) begin
                next_state = B;
                z <= 0;
            end else begin
                next_state = B;
                z <= 1;
            end
        end
    endcase
end

endmodule
