module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case (state)
        1'b0: begin
            q <= 1'b0;
            p <= 1'b0;
            if (a == 1'b1) begin
                state <= 1'b1;
            end
        end
        1'b1: begin
            p <= 1'b1;
            if (a == 1'b0) begin
                state <= 1'b0;
                q <= 1'b1;
            end
        end
    endcase
end

endmodule
