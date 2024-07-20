module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case ({state, a})
        2'b00: begin
            p <= 0;
            q <= 0;
        end
        2'b01: begin
            p <= 0;
            q <= 0;
        end
        2'b10: begin
            p <= 0;
            q <= 1;
        end
        2'b11: begin
            p <= 1;
            q <= 0;
        end
    endcase
    state <= {a, state[0]};
end

endmodule
