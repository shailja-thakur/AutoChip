module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    case ({a, b, state})
        3'b000: begin
            state <= 0;
            q <= 0;
        end
        3'b001: begin
            state <= 0;
            q <= 1;
        end
        3'b010: begin
            state <= 0;
            q <= 0;
        end
        3'b011: begin
            state <= 1;
            q <= 1;
        end
        3'b100: begin
            state <= 0;
            q <= 0;
        end
        3'b101: begin
            state <= 1;
            q <= 1;
        end
        3'b110: begin
            state <= 1;
            q <= 0;
        end
        3'b111: begin
            state <= 1;
            q <= 1;
        end
    endcase
end

endmodule
