module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= 2'b00;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: begin
            next_state = 2'b01;
            f = 1'b0;
            g = 1'b0;
        end
        2'b01: begin
            next_state = 2'b10;
            f = 1'b1;
            g = 1'b0;
        end
        2'b10: begin
            if (x == 1'b1) begin
                next_state = 2'b11;
                f = 1'b0;
                g = 1'b0;
            end else begin
                next_state = 2'b10;
                f = 1'b0;
                g = 1'b1;
            end
        end
        2'b11: begin
            if (x == 1'b0) begin
                next_state = 2'b10;
                f = 1'b0;
                g = 1'b0;
            end else begin
                next_state = 2'b11;
                f = 1'b0;
                g = 1'b1;
            end
        end
    endcase
end

endmodule
