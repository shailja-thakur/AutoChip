module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B; // Asynchronously reset to state B
        end
        else begin
            case (state)
                A: begin
                    if (in == 1'b0) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                end
                B: begin
                    if (in == 1'b0) begin
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
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
