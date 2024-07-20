module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

always@(posedge clock) begin
    case ({a, p, q})
        // Initial state
        {1'b0, 1'b0, 1'b0}: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        // Transition state
        {1'b0, 1'b0, 1'b1}: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        // State 1
        {1'b0, 1'b1, 1'b0}: begin
            p <= 1'b1;
            q <= 1'b0;
        end
        // State 2
        {1'b0, 1'b1, 1'b1}: begin
            p <= 1'b0;
            q <= 1'b0;
        end
        // State 3
        {1'b1, 1'b0, 1'b0}: begin
            p <= 1'b0;
            q <= 1'b1;
        end
        // State 4
        {1'b1, 1'b0, 1'b1}: begin
            p <= 1'b0;
            q <= 1'b1;
        end
        // State 5
        {1'b1, 1'b1, 1'b0}: begin
            p <= 1'b1;
            q <= 1'b1;
        end
        // Final state
        default: begin
            p <= 1'b0;
            q <= 1'b0;
        end
    endcase
end

endmodule
