module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Internal state register
    reg state;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= B; // Asynchronous reset to state B
            out <= 1'b1; // Output high when in state B
        end
        else begin
            case (state)
                A: begin
                    if (in == 1'b0) begin
                        state <= B;
                        out <= 1'b1;
                    end
                    else begin
                        state <= A;
                        out <= 1'b0;
                    end
                end
                B: begin
                    if (in == 1'b0) begin
                        state <= B;
                        out <= 1'b1;
                    end
                    else begin
                        state <= A;
                        out <= 1'b0;
                    end
                end
                default: begin
                    state <= B;
                    out <= 1'b1;
                end
            endcase
        end
    end

endmodule
