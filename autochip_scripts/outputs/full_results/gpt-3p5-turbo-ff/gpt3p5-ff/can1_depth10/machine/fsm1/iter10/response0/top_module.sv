module top_module (
    input wire clk,
    input wire in,
    input wire areset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b10;
    end else begin
        state <= next_state;
    end
end

always @(state, in) begin
    case (state)
        2'b00: begin
            if (in) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        end
        2'b01: begin
            if (in) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b10;
            end
        end
        2'b10: begin
            if (in) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b00;
            end
        end
        default: begin
            next_state = 2'b10;
        end
    endcase
end

always @(state) begin
    if (state == 2'b10)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule
