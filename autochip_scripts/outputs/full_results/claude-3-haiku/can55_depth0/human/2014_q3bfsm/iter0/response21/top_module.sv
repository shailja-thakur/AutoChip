module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        present_state <= 3'b000;
    end
    else begin
        present_state <= next_state;
    end
end

always @(*) begin
    case (present_state)
        3'b000: begin
            z = 1'b0;
            next_state = x ? 3'b001 : 3'b000;
        end
        3'b001: begin
            z = 1'b0;
            next_state = x ? 3'b100 : 3'b001;
        end
        3'b010: begin
            z = 1'b0;
            next_state = x ? 3'b001 : 3'b010;
        end
        3'b011: begin
            z = 1'b1;
            next_state = x ? 3'b010 : 3'b001;
        end
        3'b100: begin
            z = 1'b1;
            next_state = x ? 3'b100 : 3'b011;
        end
        default: begin
            z = 1'b0;
            next_state = 3'b000;
        end
    endcase
end

endmodule
