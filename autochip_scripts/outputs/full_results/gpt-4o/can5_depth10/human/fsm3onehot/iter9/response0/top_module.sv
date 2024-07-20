module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    // State encoding
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    // State transition logic
    always @(*) begin
        next_state = 4'b0000; // Default to no state to handle invalid inputs
        out = 0;              // Default output

        case (state)
            A: begin
                next_state = in ? B : A;
            end
            B: begin
                next_state = in ? B : C;
            end
            C: begin
                next_state = in ? D : A;
            end
            D: begin
                next_state = in ? B : C;
            end
            default: begin
                next_state = 4'b0000; // Reset to 0 if invalid state
            end
        endcase

        // Output logic
        if (state == D) begin
            out = 1;
        end else begin
            out = 0;
        end
    end

endmodule
