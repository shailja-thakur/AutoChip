module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg [2:0] state;

always@(posedge clock) begin
    case (state)
        // Initial state
        0: begin
            p <= 1'b0;
            q <= 1'b0;
            if (a == 1'b0) begin
                state <= 1;
            end
        end
        // State 1
        1: begin
            p <= 1'b0;
            q <= 1'b0;
            if (a == 1'b0) begin
                state <= 2;
            end
        end
        // State 2
        2: begin
            p <= 1'b1;
            q <= 1'b0;
            if (a == 1'b1) begin
                state <= 3;
            end
        end
        // State 3
        3: begin
            p <= 1'b0;
            q <= 1'b0;
            if (a == 1'b0) begin
                state <= 4;
            end
        end
        // State 4
        4: begin
            p <= 1'b0;
            q <= 1'b1;
            if (a == 1'b1) begin
                state <= 5;
            end
        end
        // State 5
        5: begin
            p <= 1'b1;
            q <= 1'b1;
            if (a == 1'b0) begin
                state <= 6;
            end
        end
        // Final state
        default: begin
            p <= 1'b0;
            q <= 1'b0;
            state <= 0;
        end
    endcase
end

endmodule
