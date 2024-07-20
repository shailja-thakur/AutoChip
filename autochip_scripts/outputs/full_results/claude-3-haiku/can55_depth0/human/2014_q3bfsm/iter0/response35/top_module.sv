module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] curr_state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        curr_state <= 3'b000;
    end else begin
        curr_state <= next_state;
    end
end

always @(*) begin
    case (curr_state)
        3'b000: begin
            next_state = x ? 3'b001 : 3'b000;
            z = 1'b0;
        end
        3'b001: begin
            next_state = x ? 3'b100 : 3'b001;
            z = 1'b0;
        end
        3'b010: begin
            next_state = x ? 3'b001 : 3'b010;
            z = 1'b0;
        end
        3'b011: begin
            next_state = x ? 3'b010 : 3'b001;
            z = 1'b1;
        end
        3'b100: begin
            next_state = x ? 3'b100 : 3'b011;
            z = 1'b1;
        end
        default: begin
            next_state = 3'b000;
            z = 1'b0;
        end
    endcase
end

endmodule
