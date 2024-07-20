module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg current_state, next_state;

always @(posedge clk) begin
    current_state <= next_state;
    q <= next_state;
end

always @(*) begin
    case ({a, b, current_state})
        3'b000: begin
            next_state = 0;
            state = 0;
        end
        3'b001: begin
            next_state = 1;
            state = 0;
        end
        3'b010: begin
            next_state = 0;
            state = 0;
        end
        3'b011: begin
            next_state = 0;
            state = 0;
        end
        3'b100: begin
            next_state = 1;
            state = 1;
        end
        3'b101: begin
            next_state = 0;
            state = 1;
        end
        3'b110: begin
            next_state = 1;
            state = 1;
        end
        3'b111: begin
            next_state = 0;
            state = 1;
        end
    endcase
end

endmodule
