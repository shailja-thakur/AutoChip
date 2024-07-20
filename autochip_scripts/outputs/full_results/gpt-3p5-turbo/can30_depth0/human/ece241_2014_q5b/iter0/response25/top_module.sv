module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state, next_state;
assign z = state[1];
    
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: begin
            if (x == 1'b0) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        end
        2'b01: begin
            if (x == 1'b0) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b10;
            end
        end
        2'b10: begin
            if (x == 1'b0) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b01;
            end
        end
        default: begin
            next_state = 2'b00;
        end
    endcase
end

endmodule
