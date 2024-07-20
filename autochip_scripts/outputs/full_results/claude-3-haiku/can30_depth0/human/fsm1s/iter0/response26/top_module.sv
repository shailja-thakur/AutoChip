module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State variables
    reg state;
    parameter A = 1'b0, B = 1'b1;

    // Next state logic
    always @(posedge clk) begin
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
            endcase
        end
    end

    // Output logic
    always @(posedge clk) begin
        case (state)
            A: out <= 1'b0;
            B: out <= 1'b1;
        endcase
    end

endmodule
