module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;
reg [3:1] next_state;

always @(posedge clk) begin
    if (!resetn)
        state <= 3'b001;
    else
        state <= next_state;
end

always @(state or r) begin
    case (state)
        3'b001: begin
            next_state = r[1] ? 3'b010 : (r[2] ? 3'b011 : (r[3] ? 3'b100 : 3'b001));
        end
        3'b010: begin
            next_state = r[1] ? 3'b010 : 3'b001;
        end
        3'b011: begin
            next_state = r[2] ? 3'b011 : 3'b001;
        end
        3'b100: begin
            next_state = r[3] ? 3'b100 : 3'b001;
        end
        default: begin
            next_state = 3'b001;
        end
    endcase
end

assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0;
assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0;
assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0;

endmodule
