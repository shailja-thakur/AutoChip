module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b0;
    end else begin
        state <= next_state;
    end
end

always @(state or x) begin
    case (state)
        2'b00: begin
            if (x) begin
                next_state <= 2'b01;
            end else begin
                next_state <= 2'b00;
            end
        end
        2'b01: begin
            if (x) begin
                next_state <= 2'b00;
            end else begin
                next_state <= 2'b01;
            end
        end
        default: next_state <= 2'b00;
    endcase
end

assign z = (state == 2'b01);

endmodule
