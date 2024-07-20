module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset state to B
            state <= B;
        end
        else begin
            case (state)
                B: begin
                    // B (out=1) --in=0--> A
                    // B (out=1) --in=1--> B
                    if (in) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                    out <= 1'b1;
                end
                A: begin
                    // A (out=0) --in=0--> B
                    // A (out=0) --in=1--> A
                    if (in) begin
                        state <= A;
                    end
                    else begin
                        state <= B;
                    end
                    out <= 1'b0;
                end
                default: begin
                    state <= B;
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
