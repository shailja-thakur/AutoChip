module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg [3:0] state;

always@(posedge clock) begin
    case (state)
        // Initial state
        4'b0000: begin
            if (a) begin
                p <= 1'b0;
                q <= 1'b0;
                state <= 4'b0001;
            end
        end
        // Transition state
        4'b0001: begin
            if (!a) begin
                p <= 1'b0;
                q <= 1'b0;
                state <= 4'b0010;
            end
        end
        // State 1
        4'b0010: begin
            if (a) begin
                p <= 1'b1;
                q <= 1'b0;
                state <= 4'b0011;
            end
        end
        // State 2
        4'b0011: begin
            if (!a) begin
                p <= 1'b0;
                q <= 1'b0;
                state <= 4'b0100;
            end
        end
        // State 3
        4'b0100: begin
            if (a) begin
                p <= 1'b0;
                q <= 1'b1;
                state <= 4'b0101;
            end
        end
        // State 4
        4'b0101: begin
            if (!a) begin
                p <= 1'b0;
                q <= 1'b1;
                state <= 4'b0110;
            end
        end
        // State 5
        4'b0110: begin
            if (a) begin
                p <= 1'b1;
                q <= 1'b1;
                state <= 4'b0111;
            end
        end
        // Final state
        default: begin
            p <= 1'b0;
            q <= 1'b0;
            state <= 4'b0000;
        end
    endcase
end

endmodule
