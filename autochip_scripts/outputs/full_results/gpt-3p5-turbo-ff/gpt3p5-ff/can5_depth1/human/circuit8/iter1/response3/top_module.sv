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
        3'b000: begin
            p <= 1'b0;
            q <= 1'b0;
            if (a == 1'b0)
                state <= 3'b001;
        end
        // Transition state
        3'b001: begin
            if (a == 1'b1)
                state <= 3'b010;
        end
        // State 1
        3'b010: begin
            p <= 1'b1;
            q <= 1'b0;
            if (a == 1'b0)
                state <= 3'b011;
        end
        // State 2
        3'b011: begin
            if (a == 1'b1)
                state <= 3'b100;
        end
        // State 3
        3'b100: begin
            p <= 1'b0;
            q <= 1'b1;
            if (a == 1'b0)
                state <= 3'b101;
        end
        // State 4
        3'b101: begin
            if (a == 1'b1)
                state <= 3'b110;
        end
        // State 5
        3'b110: begin
            p <= 1'b1;
            q <= 1'b1;
            if (a == 1'b0)
                state <= 3'b111;
        end
        // Final state
        3'b111: begin
            p <= 1'b0;
            q <= 1'b0;
            if (a == 1'b1)
                state <= 3'b000;
        end
    endcase
end

endmodule
