module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // State definitions
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
            end
            C: begin
                if (in == 0)
                    next_state = A;
                else
                    next_state = D;
            end
            D: begin
                if (in == 0)
                    next_state = C;
                else
                    next_state = B;
            end
            default: next_state = 4'b0000; // Default state (shouldn't happen)
        endcase
    end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
