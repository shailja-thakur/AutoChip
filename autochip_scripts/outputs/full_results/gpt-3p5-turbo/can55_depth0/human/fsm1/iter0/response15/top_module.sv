module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states
    parameter B = 0;
    parameter A = 1;

    // Define current state variable
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else begin
            case (state)
                B: begin
                    if (in)
                        state <= A;
                    else
                        state <= B;
                end
                A: begin
                    if (in)
                        state <= A;
                    else
                        state <= B;
                end
                default: state <= B;
            endcase
        end
    end

    // Output logic
    always @(state) begin
        case (state)
            B: out <= 1'b1;
            A: out <= 1'b0;
            default: out <= 1'b0;
        endcase
    end
endmodule
