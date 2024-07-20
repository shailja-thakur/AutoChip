module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [3:0] state;
reg [2:0] next_state;
reg z;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 4'b0000;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        4'b0000: begin
            next_state = (x) ? 4'b0001 : 4'b0000;
            z = (x) ? 1'b1 : 1'b0;
        end
        4'b0001: begin
            next_state = (x) ? 4'b0010 : 4'b0001;
            z = (x) ? 1'b0 : 1'b1;
        end
        4'b0010: begin
            next_state = (x) ? 4'b0001 : 4'b0011;
            z = (x) ? 1'b1 : 1'b0;
        end
        4'b0011: begin
            next_state = (x) ? 4'b0010 : 4'b0011;
            z = (x) ? 1'b0 : 1'b1;
        end
    endcase
end

endmodule
