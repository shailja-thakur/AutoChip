module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Declare the state register
    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end
        else begin
            case (state)
                A: begin
                    if (in) begin
                        state <= A;
                    end
                    else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                end
                default: begin
                    state <= B;
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A: begin
                out = 1'b0;
            end
            B: begin
                out = 1'b1;
            end
            default: begin
                out = 1'b0;
            end
        endcase
    end

endmodule
