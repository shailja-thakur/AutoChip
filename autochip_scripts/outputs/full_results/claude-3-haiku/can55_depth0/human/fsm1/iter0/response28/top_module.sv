module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State variables
    reg state;
    parameter A = 1'b0, B = 1'b1;

    // Asynchronous reset
    always @(posedge areset) begin
        state <= B;
        out <= 1'b1;
    end

    // State transition logic
    always @(posedge clk) begin
        case (state)
            B: begin
                if (in == 1'b0) begin
                    state <= A;
                    out <= 1'b0;
                end else begin
                    state <= B;
                    out <= 1'b1;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    state <= B;
                    out <= 1'b1;
                end else begin
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

endmodule
