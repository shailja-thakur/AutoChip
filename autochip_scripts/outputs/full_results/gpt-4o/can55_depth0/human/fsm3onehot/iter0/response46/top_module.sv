module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

    // One-hot encoded state values
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    always @(*) begin
        case (state)
            A: begin
                next_state = in ? B : A;
                out = 0;
            end
            B: begin
                next_state = in ? B : C;
                out = 0;
            end
            C: begin
                next_state = in ? D : A;
                out = 0;
            end
            D: begin
                next_state = in ? B : C;
                out = 1;
            end
            default: begin
                next_state = 4'b0000; // Default case to avoid latches
                out = 0;
            end
        endcase
    end
endmodule
