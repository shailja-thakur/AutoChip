module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the two states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Define the current state register
    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the state to B
            state <= B;
        end
        else begin
            case (state)
                B: begin
                    // State B: out = 1
                    out <= 1'b1;
                    if (in) begin
                        // B --in=1--> B
                        state <= B;
                    end
                    else begin
                        // B --in=0--> A
                        state <= A;
                    end
                end
                A: begin
                    // State A: out = 0
                    out <= 1'b0;
                    if (in) begin
                        // A --in=1--> A
                        state <= A;
                    end
                    else begin
                        // A --in=0--> B
                        state <= B;
                    end
                end
            endcase
        end
    end

endmodule
