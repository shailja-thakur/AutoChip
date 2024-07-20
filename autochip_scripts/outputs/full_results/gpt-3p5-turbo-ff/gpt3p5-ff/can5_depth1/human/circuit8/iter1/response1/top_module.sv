module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case (state)
        // Initial state
        0: begin
            p <= 0;
            q <= 0;
            if (a == 0)
                state <= 1;
        end
        // State 1
        1: begin
            if (a == 0)
                state <= 2;
        end
        // State 2
        2: begin
            if (a == 1)
                state <= 3;
        end
        // State 3
        3: begin
            if (a == 0)
                state <= 4;
        end
        // State 4
        4: begin
            if (a == 1)
                state <= 5;
        end
        // State 5
        5: begin
            if (a == 0)
                state <= 6;
        end
        // Final state
        default: begin
            p <= 0;
            q <= 0;
            state <= 0;
        end
    endcase
end

always @(state) begin
    case (state)
        // Initial state
        0: begin
            p <= 0;
            q <= 0;
        end
        // State 1
        1: begin
            p <= 0;
            q <= 0;
        end
        // State 2
        2: begin
            p <= 1;
            q <= 0;
        end
        // State 3
        3: begin
            p <= 0;
            q <= 0;
        end
        // State 4
        4: begin
            p <= 1;
            q <= 0;
        end
        // State 5
        5: begin
            p <= 1;
            q <= 1;
        end
        // Final state
        default: begin
            p <= 0;
            q <= 0;
        end
    endcase
end

endmodule
