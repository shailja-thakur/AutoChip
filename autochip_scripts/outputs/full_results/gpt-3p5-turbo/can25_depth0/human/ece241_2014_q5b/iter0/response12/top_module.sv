module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state, next_state;
reg z_output;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
        z_output <= 1'b0;
    end
    else begin
        state <= next_state;
        z_output <= (state == B) ? 1'b0 : 1'b1;
    end
end

always @* begin
    case (state)
        A: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = B;
            end
        end
    endcase
end

assign z = z_output;

endmodule
