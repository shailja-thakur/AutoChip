module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Define the state register
    reg state;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= B;
            out <= 1'b1;
        end
        else begin
            case (state)
                B: begin
                    out <= 1'b1;
                    if (in == 1'b0) begin
                        state <= A;
                    end
                    else begin
                        state <= B;
                    end
                end
                A: begin
                    out <= 1'b0;
                    if (in == 1'b0) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
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
