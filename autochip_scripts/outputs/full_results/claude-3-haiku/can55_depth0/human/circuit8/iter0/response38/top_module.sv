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
            // Initial state
            p <= 0;
            q <= 0;
            if (a == 1) begin
                state <= 1'b1;
            end
        end
        1'b1: begin
            // State when a is 1
            p <= 0;
            q <= 1;
            if (a == 0) begin
                state <= 1'b0;
            end
        end
    endcase
end

endmodule
