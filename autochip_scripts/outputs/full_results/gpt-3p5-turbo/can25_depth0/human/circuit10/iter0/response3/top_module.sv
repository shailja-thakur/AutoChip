module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg flip_flop;

always @(posedge clk) begin
    case ({a, b, flip_flop})
        3'b001: flip_flop <= 1'b1;
        3'b010: flip_flop <= 1'b1;
        3'b011: flip_flop <= 1'b0;
        default: flip_flop <= 1'b0;
    endcase
end

always @(*) begin
    case ({a, b, flip_flop})
        3'b001: begin
            q = 1'b1;
            state = 1'b0;
        end
        3'b010: begin
            q = 1'b1;
            state = 1'b0;
        end
        3'b011: begin
            q = 1'b0;
            state = 1'b0;
        end
        default: begin
            q = 1'b0;
            state = 1'b0;
        end
    endcase
end

endmodule
