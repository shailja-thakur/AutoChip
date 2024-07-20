module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg current_state;

always @(posedge clk) begin
    case ({a, b, current_state})
        3'b000: begin
            q <= 0;
            state <= 0;
            current_state <= 0;
        end
        3'b001: begin
            q <= 1;
            state <= 0;
            current_state <= 1;
        end
        3'b010: begin
            q <= 1;
            state <= 0;
            current_state <= 0;
        end
        3'b011: begin
            q <= 0;
            state <= 0;
            current_state <= 1;
        end
        3'b100: begin
            q <= 1;
            state <= 1;
            current_state <= 0;
        end
        3'b101: begin
            q <= 0;
            state <= 1;
            current_state <= 1;
        end
        3'b110: begin
            q <= 0;
            state <= 0;
            current_state <= 0;
        end
        3'b111: begin
            q <= 1;
            state <= 1;
            current_state <= 1;
        end
    endcase
end

endmodule
