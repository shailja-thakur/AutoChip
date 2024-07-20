module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;  // Initializing state to B
    end else begin
        state <= next_state;
    end
end

always @(state, in) begin
    case (state)
        1'b0: begin  // State B
            if (in) begin
                next_state = 1'b0;  // Next state is B
            end else begin
                next_state = 1'b1;  // Next state is A
            end
        end
        1'b1: begin  // State A
            if (in) begin
                next_state = 1'b1;  // Next state is A
            end else begin
                next_state = 1'b0;  // Next state is B
            end
        end
    endcase
end

assign out = (state == 1'b1) ? 1'b0 : 1'b1;  // out is high when state is B, low otherwise

endmodule
